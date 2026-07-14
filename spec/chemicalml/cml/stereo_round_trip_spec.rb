# frozen_string_literal: true

require "spec_helper"

# Verifies that <atomParity> and <bondStereo> round-trip through the
# canonical Model layer without losing information.
RSpec.describe "stereo round-trip" do
  describe "atomParity (chiral centre)" do
    let(:xml) { File.read(File.expand_path("../../fixtures/schema3/molecular/chiral_center.cml", __dir__)) }
    let(:doc) { Chemicalml::Cml::Schema3::Document.from_xml(xml) }
    let(:canonical) { Chemicalml::Cml::Translator.to_canonical(doc) }

    it "parses the atomParity" do
      atom = canonical.molecules.first.atoms.first
      expect(atom.atom_parity).to be_a(Chemicalml::Model::AtomParity)
      expect(atom.atom_parity.value).to eq("1")
      expect(atom.atom_parity.atom_refs4).to eq(%w[a2 a3 a4 a5])
    end

    it "preserves atomParity through canonical → wire" do
      wire = Chemicalml::Cml::Translator.from_canonical(canonical, schema: :schema3)
      atom = wire.molecules.first.atom_array.atoms.first
      expect(atom.atom_parity).to be_a(Chemicalml::Cml::Schema3::AtomParity)
      expect(atom.atom_parity.content).to eq("1")
    end

    it "produces Schema24 AtomParity under schema24" do
      wire = Chemicalml::Cml::Translator.from_canonical(canonical, schema: :schema24)
      atom = wire.molecules.first.atom_array.atoms.first
      expect(atom.atom_parity.class).to be(Chemicalml::Cml::Schema24::AtomParity)
    end
  end

  describe "bondStereo (cis/trans)" do
    let(:xml) { File.read(File.expand_path("../../fixtures/schema3/molecular/ethene_with_bond_stereo.cml", __dir__)) }
    let(:doc) { Chemicalml::Cml::Schema3::Document.from_xml(xml) }
    let(:canonical) { Chemicalml::Cml::Translator.to_canonical(doc) }

    it "parses the bondStereo" do
      bond = canonical.molecules.first.bonds.find { |b| b.bond_stereo }
      expect(bond.bond_stereo).to be_a(Chemicalml::Model::BondStereo)
      expect(bond.bond_stereo.value).to eq("T")
      expect(bond.bond_stereo.atom_refs4).to eq(%w[a3 a1 a2 a4])
    end

    it "preserves bondStereo through canonical → wire" do
      wire = Chemicalml::Cml::Translator.from_canonical(canonical, schema: :schema3)
      bond = wire.molecules.first.bond_array.bonds.find { |b| b.bond_stereo }
      expect(bond.bond_stereo).to be_a(Chemicalml::Cml::Schema3::BondStereo)
      expect(bond.bond_stereo.content).to eq("T")
    end

    it "produces Schema24 BondStereo under schema24" do
      wire = Chemicalml::Cml::Translator.from_canonical(canonical, schema: :schema24)
      bond = wire.molecules.first.bond_array.bonds.find { |b| b.bond_stereo }
      expect(bond.bond_stereo.class).to be(Chemicalml::Cml::Schema24::BondStereo)
    end
  end
end
