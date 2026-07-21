# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'fileutils'

# Idempotent fetcher for xml-cml.org reference material.
# Re-running this task only downloads files that are missing locally.
module ReferenceFetch
  BASE = 'http://www.xml-cml.org'
  LICENSE = 'Source: <url>. Distributed by xml-cml.org under CC-BY-3.0.'

  # Map of remote URL => local path under reference-docs/.
  SOURCES = {
    # Conventions
    "#{BASE}/convention/" => 'reference-docs/conventions/index.md',
    "#{BASE}/convention/molecular" => 'reference-docs/conventions/molecular.md',
    "#{BASE}/convention/compchem" => 'reference-docs/conventions/compchem.md',
    "#{BASE}/convention/dictionary" => 'reference-docs/conventions/dictionary.md',
    "#{BASE}/convention/unit-dictionary" => 'reference-docs/conventions/unit-dictionary.md',
    "#{BASE}/convention/unitType-dictionary" => 'reference-docs/conventions/unitType-dictionary.md',
    # Dictionaries
    "#{BASE}/dictionary/" => 'reference-docs/dictionaries/index.md',
    "#{BASE}/dictionary/compchem/" => 'reference-docs/dictionaries/compchem.md',
    "#{BASE}/dictionary/cml/" => 'reference-docs/dictionaries/cml.md',
    "#{BASE}/dictionary/cml/name/" => 'reference-docs/dictionaries/cml-name.md',
    "#{BASE}/dictionary/cml/formula/" => 'reference-docs/dictionaries/cml-formula.md',
    "#{BASE}/dictionary/cif/" => 'reference-docs/dictionaries/cif.md',
    # Unit dictionaries
    "#{BASE}/unit/si/" => 'reference-docs/dictionaries/unit-si.md',
    "#{BASE}/unit/nonSi/" => 'reference-docs/dictionaries/unit-nonSi.md',
    "#{BASE}/unit/unitType/" => 'reference-docs/dictionaries/unit-type.md',
    # Schema / spec
    'https://www.xml-cml.org/schema/cmllite.html' => 'reference-docs/cmllite.html',
    # Examples
    "#{BASE}/examples/schema3/molecular/" => 'reference-docs/examples/schema3-molecular-index.md',
    "#{BASE}/examples/schema3/compchem/" => 'reference-docs/examples/schema3-compchem-index.md',
    "#{BASE}/examples/schema24/" => 'reference-docs/examples/schema24-index.md'
  }.freeze

  def self.fetch_all
    SOURCES.each do |url, path|
      fetch_one(url, path)
      sleep 0.5
    end
  end

  def self.fetch_one(url, path)
    full = File.expand_path(path, project_root)
    if File.exist?(full)
      puts "skip     #{path} (exists)"
      return
    end

    FileUtils.mkdir_p(File.dirname(full))
    body = http_get(url)
    if body.nil?
      File.write("#{full}.failed", "GET #{url} -> failed\n")
      warn "FAILED  #{url}"
      return
    end

    if path.end_with?('.html')
      File.write(full, body)
    else
      File.write(full, header(url) + body)
    end
    puts "saved   #{path}"
  end

  def self.header(url)
    "<!-- Source: #{url} -->\n<!-- License: CC-BY-3.0 (http://creativecommons.org/licenses/by/3.0/) -->\n\n"
  end

  def self.http_get(url, limit = 5)
    raise 'too many redirects' if limit.zero?

    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.is_a?(URI::HTTPS)
    http.read_timeout = 30
    req = Net::HTTP::Get.new(uri, 'User-Agent' => 'chemicalml-gem-reference-fetch')
    res = http.request(req)

    case res
    when Net::HTTPSuccess then res.body
    when Net::HTTPRedirection then http_get(res['location'], limit - 1)
    end
  rescue StandardError => e
    warn "  error fetching #{url}: #{e.message}"
    nil
  end

  def self.project_root
    File.expand_path('..', __dir__)
  end
end

namespace :reference do
  desc 'Download all xml-cml.org reference material into reference-docs/. Idempotent.'
  task :fetch do
    ReferenceFetch.fetch_all
  end
end
