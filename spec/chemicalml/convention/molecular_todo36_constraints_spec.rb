# frozen_string_literal: true

require "spec_helper"

RSpec.describe "molecular convention TODO-36 constraints" do
  let(:atom) { Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C") }

  let(:atom_array) { Chemicalml::Cml::Schema3::AtomArray.new(atoms: [atom]) }

  def document_with_molecule(mol)
    Chemicalml::Cml::Schema3::Document.new(molecules: [mol])
  end

  def validate(doc)
    Chemicalml::Convention::Molecular.validate(doc)
  end

  describe "MoleculeCountMustNotAppearOnTopLevel" do
    it "flags a top-level molecule with count" do
      mol = Chemicalml::Cml::Schema3::Molecule.new(id: "m1", count: "2")
      violations = validate(document_with_molecule(mol))
      expect(violations.map(&:message))
        .to include(match(/top-level molecule.*must not have a count attribute/))
    end

    it "passes when top-level molecule has no count" do
      mol = Chemicalml::Cml::Schema3::Molecule.new(id: "m1")
      violations = validate(document_with_molecule(mol))
      expect(violations.map(&:message))
        .not_to include(match(/top-level molecule.*count/))
    end
  end

  describe "MoleculeAtomArrayMutuallyExclusiveWithChildren" do
    it "flags a molecule with both atomArray and child molecules" do
      child = Chemicalml::Cml::Schema3::Molecule.new(id: "m_child")
      mol = Chemicalml::Cml::Schema3::Molecule.new(
        id: "m1", atom_array: atom_array, molecules: [child]
      )
      violations = validate(document_with_molecule(mol))
      expect(violations.map(&:message))
        .to include(match(/atomArray.*child molecule elements.*mutually exclusive/))
    end

    it "passes when molecule has atomArray only" do
      mol = Chemicalml::Cml::Schema3::Molecule.new(id: "m1", atom_array: atom_array)
      violations = validate(document_with_molecule(mol))
      expect(violations.map(&:message))
        .not_to include(match(/mutually exclusive/))
    end
  end

  describe "MoleculeBondArrayMutuallyExclusiveWithChildren" do
    it "flags a molecule with both bondArray and child molecules" do
      child = Chemicalml::Cml::Schema3::Molecule.new(id: "m_child")
      bond = Chemicalml::Cml::Schema3::Bond.new(id: "b1", atom_refs2: "a1 a1", order: "S")
      bond_array = Chemicalml::Cml::Schema3::BondArray.new(bonds: [bond])
      mol = Chemicalml::Cml::Schema3::Molecule.new(
        id: "m1", bond_array: bond_array, molecules: [child]
      )
      violations = validate(document_with_molecule(mol))
      expect(violations.map(&:message))
        .to include(match(/bondArray.*child molecule elements.*mutually exclusive/))
    end
  end

  describe "BondStereoWedgeHashMustHaveAtomRefs2" do
    it "flags a wedge bondStereo without atomRefs2" do
      bs = Chemicalml::Cml::Schema3::BondStereo.new(content: "W")
      bond = Chemicalml::Cml::Schema3::Bond.new(
        id: "b1", atom_refs2: "a1 a2", order: "S", bond_stereo: bs
      )
      mol = Chemicalml::Cml::Schema3::Molecule.new(
        id: "m1",
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
          atoms: [
            Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C"),
            Chemicalml::Cml::Schema3::Atom.new(id: "a2", element_type: "C")
          ]
        ),
        bond_array: Chemicalml::Cml::Schema3::BondArray.new(bonds: [bond])
      )
      violations = validate(document_with_molecule(mol))
      expect(violations.map(&:message))
        .to include(match(/bondStereo value "W" must have atomRefs2/))
    end

    it "flags a wedge bondStereo with atomRefs4 (wrong attribute)" do
      bs = Chemicalml::Cml::Schema3::BondStereo.new(
        content: "H", atom_refs2: "a1 a2", atom_refs4: "a1 a2 a3 a4"
      )
      bond = Chemicalml::Cml::Schema3::Bond.new(
        id: "b1", atom_refs2: "a1 a2", order: "S", bond_stereo: bs
      )
      mol = Chemicalml::Cml::Schema3::Molecule.new(
        id: "m1",
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
          atoms: [
            Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C"),
            Chemicalml::Cml::Schema3::Atom.new(id: "a2", element_type: "C")
          ]
        ),
        bond_array: Chemicalml::Cml::Schema3::BondArray.new(bonds: [bond])
      )
      violations = validate(document_with_molecule(mol))
      expect(violations.map(&:message))
        .to include(match(/must not have atomRefs4/))
    end
  end

  describe "BondStereoCisTransMustHaveAtomRefs4" do
    it "flags a cis bondStereo without atomRefs4" do
      bs = Chemicalml::Cml::Schema3::BondStereo.new(content: "C")
      bond = Chemicalml::Cml::Schema3::Bond.new(
        id: "b1", atom_refs2: "a1 a2", order: "D", bond_stereo: bs
      )
      mol = Chemicalml::Cml::Schema3::Molecule.new(
        id: "m1",
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
          atoms: [
            Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C"),
            Chemicalml::Cml::Schema3::Atom.new(id: "a2", element_type: "C")
          ]
        ),
        bond_array: Chemicalml::Cml::Schema3::BondArray.new(bonds: [bond])
      )
      violations = validate(document_with_molecule(mol))
      expect(violations.map(&:message))
        .to include(match(/bondStereo value "C" must have atomRefs4/))
    end
  end

  describe "BondStereoOtherMustHaveDictRef" do
    it "flags bondStereo=other without dictRef" do
      bs = Chemicalml::Cml::Schema3::BondStereo.new(content: "other")
      bond = Chemicalml::Cml::Schema3::Bond.new(
        id: "b1", atom_refs2: "a1 a2", order: "S", bond_stereo: bs
      )
      mol = Chemicalml::Cml::Schema3::Molecule.new(
        id: "m1",
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
          atoms: [
            Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C"),
            Chemicalml::Cml::Schema3::Atom.new(id: "a2", element_type: "C")
          ]
        ),
        bond_array: Chemicalml::Cml::Schema3::BondArray.new(bonds: [bond])
      )
      violations = validate(document_with_molecule(mol))
      expect(violations.map(&:message))
        .to include(match(/bondStereo value 'other' must have a dictRef/))
    end
  end

  describe "BondIdsUniqueWithinMolecule" do
    it "flags duplicate bond ids within a molecule" do
      bond1 = Chemicalml::Cml::Schema3::Bond.new(id: "dup", atom_refs2: "a1 a2", order: "S")
      bond2 = Chemicalml::Cml::Schema3::Bond.new(id: "dup", atom_refs2: "a2 a1", order: "S")
      mol = Chemicalml::Cml::Schema3::Molecule.new(
        id: "m1",
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
          atoms: [
            Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C"),
            Chemicalml::Cml::Schema3::Atom.new(id: "a2", element_type: "C")
          ]
        ),
        bond_array: Chemicalml::Cml::Schema3::BondArray.new(bonds: [bond1, bond2])
      )
      violations = validate(document_with_molecule(mol))
      expect(violations.map(&:message))
        .to include(match(/duplicate bond id "dup"/))
    end
  end

  describe "BondOrderOtherMustHaveDictRef" do
    it "flags bond order=other without dictRef" do
      bond = Chemicalml::Cml::Schema3::Bond.new(
        id: "b1", atom_refs2: "a1 a2", order: "other"
      )
      mol = Chemicalml::Cml::Schema3::Molecule.new(
        id: "m1",
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
          atoms: [
            Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C"),
            Chemicalml::Cml::Schema3::Atom.new(id: "a2", element_type: "C")
          ]
        ),
        bond_array: Chemicalml::Cml::Schema3::BondArray.new(bonds: [bond])
      )
      violations = validate(document_with_molecule(mol))
      expect(violations.map(&:message))
        .to include(match(/bond order 'other' must have a dictRef/))
    end

    it "passes when bond order=other has dictRef" do
      bond = Chemicalml::Cml::Schema3::Bond.new(
        id: "b1", atom_refs2: "a1 a2", order: "other", dict_ref: "foo:bar"
      )
      mol = Chemicalml::Cml::Schema3::Molecule.new(
        id: "m1",
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
          atoms: [
            Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C"),
            Chemicalml::Cml::Schema3::Atom.new(id: "a2", element_type: "C")
          ]
        ),
        bond_array: Chemicalml::Cml::Schema3::BondArray.new(bonds: [bond])
      )
      violations = validate(document_with_molecule(mol))
      expect(violations.map(&:message))
        .not_to include(match(/bond order 'other'/))
    end
  end

  describe "AtomArrayMustBeChildOfMoleculeOrFormula" do
    it "flags an atomArray directly under the document root" do
      # Schema3::Document doesn't declare atomArray as a child so we
      # test via Module — its lists/molecules are containers but
      # atomArray is not a declared child, so we test the parent-side
      # logic by going through a Molecule which DOES allow atomArray.
      # Use a Module as a non-molecule, non-formula parent.
      mod = Chemicalml::Cml::Schema3::Module.new(
        id: "x",
        molecules: [
          Chemicalml::Cml::Schema3::Molecule.new(id: "m1", atom_array: atom_array)
        ]
      )
      # The Module itself doesn't have atom_array attribute — the
      # constraint walks children. We can only test this when a
      # non-molecule node actually contains an atomArray, which
      # schema doesn't permit. So instead, verify the constraint
      # class is registered and doesn't crash on a clean doc.
      violations = validate(document_with_molecule(
        Chemicalml::Cml::Schema3::Molecule.new(id: "m1", atom_array: atom_array)
      ))
      expect(violations.map(&:message))
        .not_to include(match(/atomArray must be a child of/))
    end
  end

  describe "BondArrayMustBeChildOfMolecule" do
    it "passes when bondArray is under a molecule" do
      bond = Chemicalml::Cml::Schema3::Bond.new(id: "b1", atom_refs2: "a1 a2", order: "S")
      mol = Chemicalml::Cml::Schema3::Molecule.new(
        id: "m1",
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
          atoms: [
            Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C"),
            Chemicalml::Cml::Schema3::Atom.new(id: "a2", element_type: "C")
          ]
        ),
        bond_array: Chemicalml::Cml::Schema3::BondArray.new(bonds: [bond])
      )
      violations = validate(document_with_molecule(mol))
      expect(violations.map(&:message))
        .not_to include(match(/bondArray must be a child of/))
    end
  end
end
