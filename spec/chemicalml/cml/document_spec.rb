# frozen_string_literal: true

require "spec_helper"

RSpec.describe ChemicalML::Cml::Document do
  it "parses a full CML document with one molecule" do
    xml = <<~XML
      <cml>
        <molecule id="m1">
          <name>water</name>
          <atomArray>
            <atom id="a1" elementType="H" count="2"/>
            <atom id="a2" elementType="O"/>
          </atomArray>
        </molecule>
      </cml>
    XML

    doc = described_class.from_xml(xml)
    expect(doc.molecules.length).to eq(1)
    mol = doc.molecules.first
    expect(mol.id).to eq("m1")
    expect(mol.names.first.content).to eq("water")
    expect(mol.atom_array.atoms.map(&:element_type)).to eq(%w[H O])
  end

  it "parses a top-level reaction" do
    xml = <<~XML
      <cml>
        <reaction id="r1" title="combustion" type="forward">
          <reactantList>
            <reactant>
              <substance>
                <molecule id="r1">
                  <atomArray>
                    <atom id="a1" elementType="H" count="2"/>
                    <atom id="a2" elementType="O" count="2"/>
                  </atomArray>
                </molecule>
              </substance>
            </reactant>
          </reactantList>
          <productList>
            <product>
              <substance>
                <molecule id="p1">
                  <atomArray>
                    <atom id="pa1" elementType="H" count="2"/>
                    <atom id="pa2" elementType="O"/>
                  </atomArray>
                </molecule>
              </substance>
            </product>
          </productList>
        </reaction>
      </cml>
    XML

    doc = described_class.from_xml(xml)
    expect(doc.reactions.length).to eq(1)
    expect(doc.reactions.first.title).to eq("combustion")
  end

  it "round-trips a complex document preserving all fields" do
    original = ChemicalML::Cml::Document.new(
      molecules: [
        ChemicalML::Cml::Molecule.new(
          id: "m1",
          names: [ChemicalML::Cml::Name.new(content: "methanol")],
          atom_array: ChemicalML::Cml::AtomArray.new(
            atoms: [
              ChemicalML::Cml::Atom.new(id: "a1", element_type: "C"),
              ChemicalML::Cml::Atom.new(id: "a2", element_type: "O"),
              ChemicalML::Cml::Atom.new(id: "a3", element_type: "H", count: "4")
            ]
          ),
          bond_array: ChemicalML::Cml::BondArray.new(
            bonds: [
              ChemicalML::Cml::Bond.new(id: "b1", atom_refs2: "a1 a2", order: "S"),
              ChemicalML::Cml::Bond.new(id: "b2", atom_refs2: "a1 a3", order: "S")
            ]
          )
        )
      ]
    )

    xml = original.to_xml
    re_parsed = described_class.from_xml(xml)
    mol = re_parsed.molecules.first
    expect(mol.id).to eq("m1")
    expect(mol.names.first.content).to eq("methanol")
    expect(mol.atom_array.atoms.map(&:element_type)).to eq(%w[C O H])
    expect(mol.bond_array.bonds.length).to eq(2)
    expect(mol.bond_array.bonds.first.order).to eq("S")
  end
end
