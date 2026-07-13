# frozen_string_literal: true

require "spec_helper"

RSpec.describe ChemicalML::Cml::Atom do
  it "builds with keyword args" do
    atom = described_class.new(id: "a1", element_type: "C")
    expect(atom.id).to eq("a1")
    expect(atom.element_type).to eq("C")
  end

  it "serialises to XML with camelCase wire names" do
    atom = described_class.new(id: "a1", element_type: "C", formal_charge: "2+")
    expect(atom.to_xml).to include('<atom id="a1" elementType="C" formalCharge="2+"/>')
  end

  it "round-trips through XML" do
    xml = '<atom id="a1" elementType="C" hydrogenCount="3" isotope="14"/>'
    atom = described_class.from_xml(xml)
    expect(atom.element_type).to eq("C")
    expect(atom.hydrogen_count).to eq("3")
    expect(atom.isotope).to eq("14")
    re_serialised = atom.to_xml
    expect(re_serialised).to include('elementType="C"')
    expect(re_serialised).to include('hydrogenCount="3"')
    expect(re_serialised).to include('isotope="14"')
  end
end
