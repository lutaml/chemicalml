# frozen_string_literal: true

require "spec_helper"

# Demonstrates the canon-based semantic XML comparison matcher.
# Verifies that round-trip through Chemicalml::Cml produces XML that
# is semantically equivalent to the input — tolerant of attribute
# order, whitespace, and self-closing vs empty-tag forms.
RSpec.describe "semantic XML comparison via canon" do
  it "treats attribute order as irrelevant" do
    input = '<cml xmlns="http://www.xml-cml.org/schema"><molecule id="m1" title="t"/></cml>'
    output = '<cml xmlns="http://www.xml-cml.org/schema"><molecule title="t" id="m1"/></cml>'
    expect(output).to be_xml_equivalent_to(input)
  end

  it "catches a missing attribute" do
    input  = '<cml xmlns="http://www.xml-cml.org/schema"><molecule id="m1" title="t"/></cml>'
    output = '<cml xmlns="http://www.xml-cml.org/schema"><molecule id="m1"/></cml>'
    expect(output).not_to be_xml_equivalent_to(input)
  end

  it "verifies element structure against a constructed document" do
    expected = <<~XML
      <molecule xmlns="http://www.xml-cml.org/schema" id="m1">
        <atomArray>
          <atom id="a1" elementType="C"/>
        </atomArray>
      </molecule>
    XML

    mol = Chemicalml::Cml::Schema3::Molecule.new(
      id: "m1",
      atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
        atoms: [Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C")]
      )
    )
    # Same XML modulo attribute order and whitespace.
    alt = '<molecule xmlns="http://www.xml-cml.org/schema" id="m1"><atomArray ><atom elementType="C" id="a1"/></atomArray></molecule>'
    expect(alt).to be_xml_equivalent_to(expected)
    expect(mol.to_xml).to be_xml_equivalent_to(expected)
  end
end
