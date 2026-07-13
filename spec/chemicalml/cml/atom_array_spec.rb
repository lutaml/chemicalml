# frozen_string_literal: true

require "spec_helper"

RSpec.describe Chemicalml::Cml::AtomArray do
  let(:atoms) do
    [
      Chemicalml::Cml::Atom.new(id: "a1", element_type: "H"),
      Chemicalml::Cml::Atom.new(id: "a2", element_type: "O", hydrogen_count: "2")
    ]
  end

  it "holds an atom collection" do
    array = described_class.new(atoms: atoms)
    expect(array.atoms.length).to eq(2)
  end

  it "serialises to <atomArray><atom/>...</atomArray>" do
    array = described_class.new(atoms: atoms)
    xml = array.to_xml
    expect(xml).to match(%r{<atomArray\b})
    expect(xml.scan(/<atom\b/).length).to eq(2)
  end

  it "round-trips through XML" do
    array = described_class.new(atoms: atoms)
    re_parsed = described_class.from_xml(array.to_xml)
    expect(re_parsed.atoms.length).to eq(2)
    expect(re_parsed.atoms.map(&:element_type)).to eq(%w[H O])
  end
end
