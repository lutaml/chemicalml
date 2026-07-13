# frozen_string_literal: true

require "spec_helper"

RSpec.describe Chemicalml::Model do
  describe Chemicalml::Model::Atom do
    it "stores all canonical fields" do
      atom = described_class.new(element: "C", id: "a1", isotope: "14",
                                 formal_charge: "2+", count: "2",
                                 hydrogen_count: "3", spin_multiplicity: "2",
                                 title: "methyl")
      expect(atom.element).to eq("C")
      expect(atom.isotope).to eq("14")
      expect(atom.formal_charge).to eq("2+")
    end

    it "compares by class + declared attributes" do
      a = described_class.new(element: "C", isotope: "14")
      b = described_class.new(element: "C", isotope: "14")
      c = described_class.new(element: "C", isotope: "12")
      expect(a).to eq(b)
      expect(a).not_to eq(c)
    end
  end

  describe Chemicalml::Model::Molecule do
    it "holds atoms, bonds, names, identifiers" do
      mol = described_class.new(
        id: "m1",
        atoms: [Chemicalml::Model::Atom.new(element: "H")],
        bonds: [Chemicalml::Model::Bond.new(atom_refs: ["a1", "a2"], kind: :single)],
        names: [Chemicalml::Model::Name.new(content: "water")]
      )
      expect(mol.atoms.length).to eq(1)
      expect(mol.bonds.first.kind).to eq(:single)
      expect(mol.names.first.content).to eq("water")
    end

    it "exposes children for traversal" do
      mol = described_class.new(
        atoms: [Chemicalml::Model::Atom.new(element: "H")],
        bonds: [Chemicalml::Model::Bond.new(atom_refs: [])]
      )
      expect(mol.children.length).to eq(2)
    end
  end

  describe Chemicalml::Model::Bond do
    it "maps kind to CML order code" do
      expect(described_class.new(atom_refs: [], kind: :single).cml_order).to eq("S")
      expect(described_class.new(atom_refs: [], kind: :double).cml_order).to eq("D")
      expect(described_class.new(atom_refs: [], kind: :triple).cml_order).to eq("T")
      expect(described_class.new(atom_refs: [], kind: :quadruple).cml_order).to eq("Q")
    end
  end

  describe Chemicalml::Model::Reaction do
    it "holds reactant and product lists" do
      rxn = described_class.new(
        reactant_list: Chemicalml::Model::ReactantList.new(
          reactants: [Chemicalml::Model::Reactant.new(
            substance: Chemicalml::Model::Substance.new(
              molecule: Chemicalml::Model::Molecule.new
            )
          )]
        ),
        product_list: Chemicalml::Model::ProductList.new,
        arrow: :equilibrium
      )
      expect(rxn.reactant_list.reactants.length).to eq(1)
      expect(rxn.arrow).to eq(:equilibrium)
    end
  end

  describe Chemicalml::Model::Document do
    it "is the top-level container" do
      doc = described_class.new(molecules: [Chemicalml::Model::Molecule.new])
      expect(doc.molecules.length).to eq(1)
      expect(doc.children.length).to eq(1)
    end
  end
end

RSpec.describe Chemicalml::Cml::Translator do
  def render_canonical(xml)
    doc = Chemicalml::Cml::Document.from_xml(xml)
    described_class.to_canonical(doc)
  end

  describe ".to_canonical (CML XML -> canonical model)" do
    it "converts a molecule with atoms" do
      xml = "<cml><molecule id='m1'><atomArray><atom id='a1' elementType='H' count='2'/><atom id='a2' elementType='O'/></atomArray></molecule></cml>"
      canonical = render_canonical(xml)
      mol = canonical.molecules.first
      expect(mol.id).to eq("m1")
      expect(mol.atoms.map(&:element)).to eq(%w[H O])
      expect(mol.atoms.first.count).to eq("2")
    end

    it "converts bond order to kind symbol" do
      xml = "<cml><molecule><atomArray><atom id='a1' elementType='C'/><atom id='a2' elementType='C'/></atomArray><bondArray><bond id='b1' atomRefs2='a1 a2' order='D'/></bondArray></molecule></cml>"
      canonical = render_canonical(xml)
      bond = canonical.molecules.first.bonds.first
      expect(bond.kind).to eq(:double)
      expect(bond.atom_refs).to eq(%w[a1 a2])
    end

    it "converts reaction type to arrow symbol" do
      xml = "<cml><reaction type='equilibrium'><reactantList/><productList/></reaction></cml>"
      canonical = render_canonical(xml)
      expect(canonical.reactions.first.arrow).to eq(:equilibrium)
    end
  end

  describe ".from_canonical (canonical model -> CML XML)" do
    it "serialises atoms with correct CML attributes" do
      doc = Chemicalml::Model::Document.new(
        molecules: [Chemicalml::Model::Molecule.new(
          id: "m1",
          atoms: [
            Chemicalml::Model::Atom.new(id: "a1", element: "C", isotope: "14")
          ]
        )]
      )
      wire = described_class.from_canonical(doc)
      xml = wire.to_xml
      expect(xml).to include('elementType="C"')
      expect(xml).to include('isotope="14"')
    end

    it "serialises bond with CML order code" do
      doc = Chemicalml::Model::Document.new(
        molecules: [Chemicalml::Model::Molecule.new(
          atoms: [
            Chemicalml::Model::Atom.new(id: "a1", element: "C"),
            Chemicalml::Model::Atom.new(id: "a2", element: "O")
          ],
          bonds: [Chemicalml::Model::Bond.new(id: "b1", atom_refs: %w[a1 a2], kind: :double)]
        )]
      )
      wire = described_class.from_canonical(doc)
      xml = wire.to_xml
      expect(xml).to include('order="D"')
      expect(xml).to include('atomRefs2="a1 a2"')
    end
  end

  describe "round-trip through canonical" do
    it "preserves every field on a molecule" do
      xml_in = "<cml><molecule id='m1'><atomArray><atom id='a1' elementType='C' isotope='14' formalCharge='2+'/><atom id='a2' elementType='H' count='3'/></atomArray><bondArray><bond id='b1' atomRefs2='a1 a2' order='S'/></bondArray></molecule></cml>"
      canonical = render_canonical(xml_in)
      wire = described_class.from_canonical(canonical)
      xml_out = wire.to_xml

      expect(xml_out).to include('elementType="C"')
      expect(xml_out).to include('isotope="14"')
      expect(xml_out).to include('formalCharge="2+"')
      expect(xml_out).to include('order="S"')
    end
  end
end
