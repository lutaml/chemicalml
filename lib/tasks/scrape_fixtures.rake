# frozen_string_literal: true

require "net/http"
require "uri"
require "fileutils"
require "cgi"

# Idempotent scraper for xml-cml.org example CML files. Walks the
# HTML index pages, extracts the embedded CML, and writes one `.cml`
# file per example under `spec/fixtures/`.
module FixturesScrape
  BASE = "http://www.xml-cml.org".freeze

  # Map of remote index URL => local target directory.
  INDEXES = {
    "#{BASE}/examples/schema3/molecular/" => "spec/fixtures/schema3/molecular",
    "#{BASE}/examples/schema3/compchem/"  => "spec/fixtures/schema3/compchem",
    "#{BASE}/examples/schema24/"          => "spec/fixtures/schema24"
  }.freeze

  def self.scrape_all
    INDEXES.each { |url, dir| scrape_index(url, dir) }
  end

  def self.scrape_index(index_url, target_dir)
    full_target = File.expand_path(target_dir, project_root)
    FileUtils.mkdir_p(full_target)

    body = http_get(index_url)
    unless body
      warn "FAILED to fetch #{index_url}"
      return
    end

    example_links = extract_example_links(body, index_url)
    puts "#{index_url} -> #{example_links.length} examples"
    example_links.each do |href, title|
      save_example(href, title, full_target)
      sleep 0.5
    end
  end

  def self.extract_example_links(html, base_url)
    hrefs = html.scan(/<a[^>]+href=["']([^"']+\.html?)["'][^>]*>([^<]+)<\/a>/i)
    hrefs.map do |raw_href, raw_title|
      href = URI.join(base_url, raw_href).to_s
      title = CGI.unescapeHTML(raw_title.strip)
      next nil if title.empty?
      next nil unless title.match?(/\A[a-z]/i)

      [href, title]
    end.compact
  end

  def self.save_example(url, title, target_dir)
    slug = slugify(title)
    return if slug.empty?

    path = File.join(target_dir, "#{slug}.cml")
    if File.exist?(path)
      puts "  skip     #{slug}.cml (exists)"
      return
    end

    body = http_get(url)
    unless body
      log_failure(url, target_dir)
      return
    end

    cml = extract_cml(body)
    unless cml
      log_failure(url, target_dir, reason: "no <cml> block found")
      return
    end

    File.write(path, cml.strip + "\n")
    puts "  saved   #{slug}.cml"
  end

  def self.extract_cml(html)
    match = html.match(/<cml[^>]*>.*<\/cml>/m)
    return match[0] if match

    match = html.match(/<(?:cml|module|dictionary|molecule|reaction|unitList|unitTypeList)[^>]*>.*<\/(?:cml|module|dictionary|molecule|reaction|unitList|unitTypeList)>/m)
    match && match[0]
  end

  def self.slugify(title)
    title.downcase
         .gsub(/[^a-z0-9]+/, "_")
         .gsub(/^_+|_+$/, "")
  end

  def self.http_get(url, limit = 5)
    raise "too many redirects" if limit.zero?

    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true if uri.is_a?(URI::HTTPS)
    http.read_timeout = 30
    req = Net::HTTP::Get.new(uri, "User-Agent" => "chemicalml-gem-fixtures-scrape")
    res = http.request(req)

    case res
    when Net::HTTPSuccess then res.body
    when Net::HTTPRedirection then http_get(res["location"], limit - 1)
    else nil
    end
  rescue StandardError => e
    warn "  error fetching #{url}: #{e.message}"
    nil
  end

  def self.log_failure(url, target_dir, reason: "fetch failed")
    File.open(File.join(target_dir, ".scrape-log"), "a") do |f|
      f.puts "#{Time.now.utc.iso8601}\t#{url}\t#{reason}"
    end
  end

  def self.project_root
    File.expand_path("../..", __dir__)
  end
end

require "time"

namespace :fixtures do
  desc "Scrape every xml-cml.org example CML into spec/fixtures/. Idempotent."
  task :scrape do
    FixturesScrape.scrape_all
  end
end
