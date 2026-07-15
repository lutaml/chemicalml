# frozen_string_literal: true

require "spec_helper"

RSpec.describe "atom coordinate round-trip" do
  let(:xml_with_3d_coords) do
    <<~XML
      <cml xmlns="http://www.xml-cml.org/schema">
        <molecule id="m1">
          <atomArray>
            <atom id="a1" elementType="C" x3="1.0" y3="2.0" z3="3.0"/>
            <atom id="a2" elementType="O" x3="4.0" y3="5.0" z3="6.0"/>
          </atomArray>
        </molecule>
      </cml>
    XML
  end

  it "parses 3D coordinates from wire" do
    doc = Chemicalml.parse(xml_with_3d_coords)
    atom = doc.molecules.first.atom_array.atoms.first
    expect(atom.x3).to eq("1.0")
    expect(atom.y3).to eq("2.0")
    expect(atom.z3).to eq("3.0")
  end

  it "preserves coordinates through round-trip" do
    doc = Chemicalml.parse(xml_with_3d_coords)
    atom = doc.molecules.first.atom_array.atoms.first
    expect(atom.x3).to eq("1.0")
    expect(atom.y3).to eq("2.0")
    expect(atom.z3).to eq("3.0")
  end

  it "writes coordinates back to wire" do
    doc = Chemicalml.parse(xml_with_3d_coords)
    serialized = doc.to_xml
    reparsed = Chemicalml.parse(serialized)
    atom = reparsed.molecules.first.atom_array.atoms.first
    expect(atom.x3).to eq("1.0")
    expect(atom.y3).to eq("2.0")
    expect(atom.z3).to eq("3.0")
  end

  it "handles 2D coordinates" do
    xml = <<~XML
      <cml xmlns="http://www.xml-cml.org/schema">
        <molecule id="m1">
          <atomArray>
            <atom id="a1" elementType="C" x2="100" y2="200"/>
          </atomArray>
        </molecule>
      </cml>
    XML
    doc = Chemicalml.parse(xml)
    atom = doc.molecules.first.atom_array.atoms.first
    expect(atom.x2).to eq("100")
    expect(atom.y2).to eq("200")
  end

  it "handles fractional coordinates" do
    xml = <<~XML
      <cml xmlns="http://www.xml-cml.org/schema">
        <molecule id="m1">
          <atomArray>
            <atom id="a1" elementType="Na" xFract="0.5" yFract="0.5" zFract="0.5"/>
          </atomArray>
        </molecule>
      </cml>
    XML
    doc = Chemicalml.parse(xml)
    atom = doc.molecules.first.atom_array.atoms.first
    expect(atom.xFract).to eq("0.5")
    expect(atom.yFract).to eq("0.5")
    expect(atom.zFract).to eq("0.5")
  end
end

RSpec.describe "molecular convention constraints" do
  it "flags an atom missing id" do
    doc = Chemicalml::Cml::Schema3::Document.new(
      molecules: [
        Chemicalml::Cml::Schema3::Molecule.new(
          id: "m1",
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
            atoms: [
              Chemicalml::Cml::Schema3::Atom.new(element_type: "C")
            ]
          )
        )
      ]
    )
    violations = Chemicalml::Convention::Molecular.validate(doc)
    ids = violations.map(&:message)
    expect(ids.any? { |m| m.include?("must have an id") }).to be(true)
  end

  it "flags an atom missing elementType" do
    doc = Chemicalml::Cml::Schema3::Document.new(
      molecules: [
        Chemicalml::Cml::Schema3::Molecule.new(
          id: "m1",
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
            atoms: [
              Chemicalml::Cml::Schema3::Atom.new(id: "a1")
            ]
          )
        )
      ]
    )
    violations = Chemicalml::Convention::Molecular.validate(doc)
    expect(violations.map(&:message).any? { |m| m.include?("elementType") }).to be(true)
  end

  it "flags a bond missing atomRefs2" do
    doc = Chemicalml::Cml::Schema3::Document.new(
      molecules: [
        Chemicalml::Cml::Schema3::Molecule.new(
          id: "m1",
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
            atoms: [Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C")]
          ),
          bond_array: Chemicalml::Cml::Schema3::BondArray.new(
            bonds: [Chemicalml::Cml::Schema3::Bond.new(id: "b1", order: "S")]
          )
        )
      ]
    )
    violations = Chemicalml::Convention::Molecular.validate(doc)
    expect(violations.map(&:message).any? { |m| m.include?("atomRefs2") }).to be(true)
  end

  it "flags a molecule missing id" do
    doc = Chemicalml::Cml::Schema3::Document.new(
      molecules: [
        Chemicalml::Cml::Schema3::Molecule.new(
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
            atoms: [Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C")]
          )
        )
      ]
    )
    violations = Chemicalml::Convention::Molecular.validate(doc)
    expect(violations.map(&:message).any? { |m| m.include?("molecule must have an id") }).to be(true)
  end
end
