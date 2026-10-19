# frozen_string_literal: true

require "spec_helper"
require "pathname"

# Walks every `.cml` fixture under spec/fixtures/, parses it via the
# polymorphic `Chemicalml.parse` entry point (which auto-detects
# `<cml>` vs `<module>` root), re-serializes it, and verifies the
# result via canon's `be_xml_equivalent_to` matcher.
module FixtureRoundTrip
  module_function

  def all_fixtures
    Dir.glob(File.expand_path("../fixtures/**/*.cml", __dir__)).sort
  end
end

RSpec.describe "fixture round-trip" do
  fixtures = FixtureRoundTrip.all_fixtures

  it "finds at least one fixture per category" do
    expect(fixtures).not_to be_empty
    categories = fixtures.map { |p| File.dirname(File.dirname(p)) }.uniq
    expect(categories.length).to be >= 2
  end

  # Fixtures that exercise CML features the wire classes don't fully
  # model yet (e.g. <crystal> children, deeply nested <list> with
  # arbitrary content). Skip the semantic comparison for those —
  # the structural re-parse check still runs.
  PENDING_SEMANTIC = %w[
    spec/fixtures/schema3/compchem/co2_dft_full.cml
    spec/fixtures/schema24/crystal_nacl.cml
  ].freeze

  fixtures.each do |path|
    rel = Pathname.new(path).relative_path_from(Pathname.pwd).to_s

    it "round-trips #{rel}" do
      xml = File.read(path)
      doc = Chemicalml.parse(xml)
      re_xml = doc.to_xml

      # Structural preservation: re-parse the output and verify the
      # node type and molecule/reaction counts match (for Documents)
      # or module structure matches (for Modules).
      re_doc = Chemicalml.parse(re_xml)
      expect(re_doc.class).to eq(doc.class)

      case doc
      when Chemicalml::Cml::Role::Document
        expect(re_doc.molecules.length).to eq(doc.molecules.length)
        expect(re_doc.reactions.length).to eq(doc.reactions.length)
      when Chemicalml::Cml::Role::Module
        expect(re_doc.modules.length).to eq(doc.modules.length)
      end

      # Semantic XML equivalence via canon (for fully-modelled
      # fixtures). Wrap both sides in a synthetic root element to
      # work around canon's document-level comparison limitation.
      unless PENDING_SEMANTIC.include?(rel)
        out_wrapped = "<r>#{re_xml}</r>"
        in_wrapped  = "<r>#{xml}</r>"
        expect(out_wrapped).to be_xml_equivalent_to(in_wrapped)
      end
    end
  end
end
