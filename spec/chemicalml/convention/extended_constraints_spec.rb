# frozen_string_literal: true

require "spec_helper"

RSpec.describe "molecular convention extended constraints" do
  let(:clean_atom) do
    Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C",
                                       x3: "1.0", y3: "2.0", z3: "3.0")
  end

  let(:clean_molecule) do
    Chemicalml::Cml::Schema3::Document.new(
      molecules: [
        Chemicalml::Cml::Schema3::Molecule.new(
          id: "m1",
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
            atoms: [clean_atom]
          )
        )
      ]
    )
  end

  describe "AtomCoordinatesMustBePaired" do
    it "passes when x2 and y2 are both present" do
      atom = Chemicalml::Cml::Schema3::Atom.new(
        id: "a1", element_type: "C", x2: "1.0", y2: "2.0"
      )
      doc = Chemicalml::Cml::Schema3::Document.new(
        molecules: [Chemicalml::Cml::Schema3::Molecule.new(
          id: "m1",
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(atoms: [atom])
        )]
      )
      violations = Chemicalml::Convention::Molecular.validate(doc)
      coord_violations = violations.select { |v| v.message.include?("x2") }
      expect(coord_violations).to be_empty
    end

    it "flags x2 without y2" do
      atom = Chemicalml::Cml::Schema3::Atom.new(
        id: "a1", element_type: "C", x2: "1.0"
      )
      doc = Chemicalml::Cml::Schema3::Document.new(
        molecules: [Chemicalml::Cml::Schema3::Molecule.new(
          id: "m1",
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(atoms: [atom])
        )]
      )
      violations = Chemicalml::Convention::Molecular.validate(doc)
      expect(violations.map(&:message)).to include(match(/x2 and y2/))
    end

    it "flags x3 without y3 or z3" do
      atom = Chemicalml::Cml::Schema3::Atom.new(
        id: "a1", element_type: "C", x3: "1.0"
      )
      doc = Chemicalml::Cml::Schema3::Document.new(
        molecules: [Chemicalml::Cml::Schema3::Molecule.new(
          id: "m1",
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(atoms: [atom])
        )]
      )
      violations = Chemicalml::Convention::Molecular.validate(doc)
      expect(violations.map(&:message)).to include(match(/x3.*y3.*z3/))
    end
  end

  describe "PropertyMustHaveDictRef" do
    it "flags a property without dictRef" do
      prop = Chemicalml::Cml::Schema3::Property.new(
        title: "energy",
        scalar: Chemicalml::Cml::Schema3::Scalar.new(content: "1.0")
      )
      mol = Chemicalml::Cml::Schema3::Molecule.new(
        id: "m1",
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
          atoms: [Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C")]
        ),
        properties: [prop]
      )
      doc = Chemicalml::Cml::Schema3::Document.new(molecules: [mol])
      violations = Chemicalml::Convention::Molecular.validate(doc)
      expect(violations.map(&:message)).to include(match(/property must have a dictRef/))
    end

    it "passes when property has dictRef" do
      prop = Chemicalml::Cml::Schema3::Property.new(
        dict_ref: "cml:energy", title: "energy",
        scalar: Chemicalml::Cml::Schema3::Scalar.new(content: "1.0")
      )
      mol = Chemicalml::Cml::Schema3::Molecule.new(
        id: "m1",
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
          atoms: [Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C")]
        ),
        properties: [prop]
      )
      doc = Chemicalml::Cml::Schema3::Document.new(molecules: [mol])
      violations = Chemicalml::Convention::Molecular.validate(doc)
      dictref_violations = violations.select { |v| v.message.include?("dictRef") }
      expect(dictref_violations).to be_empty
    end
  end

  describe "ScalarMustHaveDataType" do
    it "flags a scalar without dataType" do
      scalar = Chemicalml::Cml::Schema3::Scalar.new(content: "298.15")
      prop = Chemicalml::Cml::Schema3::Property.new(
        dict_ref: "cml:temp", scalar: scalar
      )
      mol = Chemicalml::Cml::Schema3::Molecule.new(
        id: "m1",
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
          atoms: [Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C")]
        ),
        properties: [prop]
      )
      doc = Chemicalml::Cml::Schema3::Document.new(molecules: [mol])
      violations = Chemicalml::Convention::Molecular.validate(doc)
      expect(violations.map(&:message)).to include(match(/scalar must have a dataType/))
    end
  end

  describe "BondOrderShouldNotBeNumeric" do
    it "warns on numeric bond order" do
      bond = Chemicalml::Cml::Schema3::Bond.new(
        id: "b1", atom_refs2: "a1 a2", order: "2"
      )
      mol = Chemicalml::Cml::Schema3::Molecule.new(
        id: "m1",
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
          atoms: [
            Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C"),
            Chemicalml::Cml::Schema3::Atom.new(id: "a2", element_type: "O")
          ]
        ),
        bond_array: Chemicalml::Cml::Schema3::BondArray.new(bonds: [bond])
      )
      doc = Chemicalml::Cml::Schema3::Document.new(molecules: [mol])
      violations = Chemicalml::Convention::Molecular.validate(doc)
      order_warnings = violations.select { |v| v.message.include?("order") }
      expect(order_warnings.any? { |v| v.warning? }).to be(true)
    end

    it "passes on valid letter order" do
      bond = Chemicalml::Cml::Schema3::Bond.new(
        id: "b1", atom_refs2: "a1 a2", order: "D"
      )
      mol = Chemicalml::Cml::Schema3::Molecule.new(
        id: "m1",
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
          atoms: [
            Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C"),
            Chemicalml::Cml::Schema3::Atom.new(id: "a2", element_type: "O")
          ]
        ),
        bond_array: Chemicalml::Cml::Schema3::BondArray.new(bonds: [bond])
      )
      doc = Chemicalml::Cml::Schema3::Document.new(molecules: [mol])
      violations = Chemicalml::Convention::Molecular.validate(doc)
      order_warnings = violations.select { |v| v.message.include?("not recommended") }
      expect(order_warnings).to be_empty
    end
  end

  describe "AtomIdMustMatchPattern" do
    it "warns on atom id starting with a digit" do
      atom = Chemicalml::Cml::Schema3::Atom.new(id: "1bad", element_type: "C")
      doc = Chemicalml::Cml::Schema3::Document.new(
        molecules: [Chemicalml::Cml::Schema3::Molecule.new(
          id: "m1",
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(atoms: [atom])
        )]
      )
      violations = Chemicalml::Convention::Molecular.validate(doc)
      id_violations = violations.select { |v| v.message.include?("must start with a letter") }
      expect(id_violations.any? { |v| v.warning? }).to be(true)
    end

    it "passes on valid atom id" do
      doc = Chemicalml::Cml::Schema3::Document.new(
        molecules: [Chemicalml::Cml::Schema3::Molecule.new(
          id: "m1",
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
            atoms: [Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C")]
          )
        )]
      )
      violations = Chemicalml::Convention::Molecular.validate(doc)
      pattern_violations = violations.select { |v| v.message.include?("must start") }
      expect(pattern_violations).to be_empty
    end
  end

  it "registers 23 molecular constraints" do
    expect(Chemicalml::Convention::Molecular.constraint_count).to eq(23)
  end
end
