# frozen_string_literal: true

require "spec_helper"

RSpec.describe Chemml::Cml::AtomArray do
  let(:atoms) do
    [
      Chemml::Cml::Atom.new(id: "a1", element_type: "H"),
      Chemml::Cml::Atom.new(id: "a2", element_type: "O", hydrogen_count: "2")
    ]
  end

  it "holds an atom collection" do
    array = described_class.new(atoms: atoms)
    expect(array.atoms.length).to eq(2)
  end

  it "serialises to <atomArray><atom/>...</atomArray>" do
    array = described_class.new(atoms: atoms)
    xml = array.to_xml
    expect(xml).to include("<atomArray>")
    expect(xml.scan("<atom ").length).to eq(2)
  end

  it "round-trips through XML" do
    array = described_class.new(atoms: atoms)
    re_parsed = described_class.from_xml(array.to_xml)
    expect(re_parsed.atoms.length).to eq(2)
    expect(re_parsed.atoms.map(&:element_type)).to eq(%w[H O])
  end
end
