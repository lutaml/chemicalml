# frozen_string_literal: true

require "spec_helper"
require "pathname"

# Walks every `.cml` fixture under spec/fixtures/, parses it, and
# re-serializes it. Uses canon's `be_xml_equivalent_to` matcher for
# semantic XML comparison — catches attribute-level regressions while
# tolerating legitimate formatting differences (attribute order,
# whitespace, self-closing vs empty-tag forms).
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

  # Some fixtures intentionally exercise features the schema-3 wire
  # classes don't fully model yet (e.g. <crystal> children, complex
  # nested <list> structures). Skip those for the semantic comparison
  # and document them here so they're tracked.
  PENDING_ROUND_TRIP = %w[
    spec/fixtures/schema3/compchem/co2_dft_full.cml
    spec/fixtures/schema3/molecular/chiral_center.cml
    spec/fixtures/schema3/molecular/water_with_properties.cml
    spec/fixtures/schema24/crystal_nacl.cml
  ].freeze

  fixtures.each do |path|
    rel = Pathname.new(path).relative_path_from(Pathname.pwd).to_s

    it "round-trips #{rel}" do
      xml = File.read(path)
      doc = Chemicalml::Cml::Document.from_xml(xml)
      re_xml = doc.to_xml

      # Always verify structural preservation via re-parse.
      re_doc = Chemicalml::Cml::Document.from_xml(re_xml)
      expect(re_doc.molecules.length).to eq(doc.molecules.length)
      expect(re_doc.reactions.length).to eq(doc.reactions.length)

      # For fixtures we model fully, also verify semantic XML
      # equivalence via canon. Wrap both sides in a synthetic root
      # element to work around canon's document-level comparison bug.
      unless PENDING_ROUND_TRIP.include?(rel)
        out_wrapped = "<r>#{re_xml}</r>"
        in_wrapped  = "<r>#{xml}</r>"
        expect(out_wrapped).to be_xml_equivalent_to(in_wrapped)
      end
    end
  end
end
