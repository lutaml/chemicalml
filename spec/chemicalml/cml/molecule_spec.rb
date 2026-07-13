# frozen_string_literal: true

require "spec_helper"

RSpec.describe ChemicalML::Cml::Molecule do
  let(:water) do
    described_class.new(
      id: "m1",
      atom_array: ChemicalML::Cml::AtomArray.new(
        atoms: [
          ChemicalML::Cml::Atom.new(id: "a1", element_type: "H", count: "2"),
          ChemicalML::Cml::Atom.new(id: "a2", element_type: "O")
        ]
      )
    )
  end

  it "serialises to <molecule><atomArray>...</atomArray></molecule>" do
    xml = water.to_xml
    expect(xml).to include("<molecule")
    expect(xml).to include("<atomArray>")
    expect(xml.scan("<atom ").length).to eq(2)
  end

  it "round-trips through XML preserving the atom array" do
    xml = water.to_xml
    re_parsed = described_class.from_xml(xml)
    expect(re_parsed.id).to eq("m1")
    expect(re_parsed.atom_array.atoms.map(&:element_type)).to eq(%w[H O])
  end

  it "supports nested molecules for sub-structures" do
    parent = described_class.new(
      id: "m1",
      molecules: [described_class.new(id: "m1a")]
    )
    xml = parent.to_xml
    expect(xml.scan("<molecule").length).to eq(2)
    re_parsed = described_class.from_xml(xml)
    expect(re_parsed.molecules.first.id).to eq("m1a")
  end

  it "carries names and identifiers" do
    mol = described_class.new(
      id: "m1",
      names: [ChemicalML::Cml::Name.new(content: "water")],
      identifiers: [ChemicalML::Cml::Identifier.new(value: "InChI=1/H2O/h1H2", convention: "iupac:inchi")]
    )
    re_parsed = described_class.from_xml(mol.to_xml)
    expect(re_parsed.names.first.content).to eq("water")
    expect(re_parsed.identifiers.first.value).to eq("InChI=1/H2O/h1H2")
  end
end
