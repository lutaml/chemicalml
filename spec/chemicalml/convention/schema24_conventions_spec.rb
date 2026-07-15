# frozen_string_literal: true

require "spec_helper"

# Verifies that convention constraints fire on Schema 2.4 documents
# the same way they fire on Schema 3 documents. The role-marker
# refactor means constraints check `is_a?(Cml::Role::Foo)` rather
# than a specific schema version's class — this spec guards against
# regressions where a future edit accidentally only checks Schema3.
RSpec.describe "conventions on Schema24 documents" do
  let(:molecular_doc) do
    Chemicalml::Cml::Schema24::Document.new(
      molecules: [
        Chemicalml::Cml::Schema24::Molecule.new(
          id: "m1",
          atom_array: Chemicalml::Cml::Schema24::AtomArray.new(
            atoms: [
              Chemicalml::Cml::Schema24::Atom.new(id: "a1", element_type: "H"),
              Chemicalml::Cml::Schema24::Atom.new(id: "a1", element_type: "O")
            ]
          )
        )
      ]
    )
  end

  let(:clean_molecular_doc) do
    Chemicalml::Cml::Schema24::Document.new(
      molecules: [
        Chemicalml::Cml::Schema24::Molecule.new(
          id: "m1",
          atom_array: Chemicalml::Cml::Schema24::AtomArray.new(
            atoms: [
              Chemicalml::Cml::Schema24::Atom.new(id: "a1", element_type: "H"),
              Chemicalml::Cml::Schema24::Atom.new(id: "a2", element_type: "O")
            ]
          ),
          bond_array: Chemicalml::Cml::Schema24::BondArray.new(
            bonds: [
              Chemicalml::Cml::Schema24::Bond.new(id: "b1", atom_refs2: "a1 a2", order: "S")
            ]
          )
        )
      ]
    )
  end

  let(:dictionary_doc) do
    Chemicalml::Cml::Schema24::Dictionary.new(
      namespace: "http://example.org/",
      entries: [
        Chemicalml::Cml::Schema24::DictionaryEntry.new(id: "foo", term: nil,
                                                        definition: "x", unit_type: "none")
      ]
    )
  end

  let(:duplicate_entry_dictionary) do
    Chemicalml::Cml::Schema24::Dictionary.new(
      namespace: "http://example.org/",
      entries: [
        Chemicalml::Cml::Schema24::DictionaryEntry.new(id: "dup", term: "First",
                                                        definition: "x", unit_type: "none"),
        Chemicalml::Cml::Schema24::DictionaryEntry.new(id: "dup", term: "Second",
                                                        definition: "x", unit_type: "none")
      ]
    )
  end

  let(:unit_list) do
    Chemicalml::Cml::Schema24::UnitList.new(
      namespace: "http://example.org/",
      units: [Chemicalml::Cml::Schema24::Unit.new(id: "broken")]
    )
  end

  let(:unit_type_list) do
    Chemicalml::Cml::Schema24::UnitTypeList.new(
      namespace: "http://example.org/",
      unit_types: [Chemicalml::Cml::Schema24::UnitType.new(id: "x", definition: "y")]
    )
  end

  it "Molecular flags duplicate atom ids in Schema24" do
    violations = Chemicalml::Convention::Molecular.validate(molecular_doc)
    expect(violations.length).to eq(1)
    expect(violations.first.message).to match(/duplicate atom id/)
  end

  it "Molecular passes a clean Schema24 document" do
    violations = Chemicalml::Convention::Molecular.validate(clean_molecular_doc)
    expect(violations).to be_empty
  end

  it "Dictionary flags an entry missing its term in Schema24" do
    violations = Chemicalml::Convention::Dictionary.validate(dictionary_doc)
    term_violations = violations.select { |v| v.message.include?("term") }
    expect(term_violations.length).to eq(1)
    expect(term_violations.first.message).to match(/term/)
  end

  it "Dictionary flags duplicate entry ids in Schema24" do
    violations = Chemicalml::Convention::Dictionary.validate(duplicate_entry_dictionary)
    dup_violations = violations.select { |v| v.message.include?("duplicate entry id") }
    expect(dup_violations.length).to eq(1)
    expect(dup_violations.first.message).to match(/duplicate entry id/)
  end

  it "UnitDictionary flags a unit missing required attributes in Schema24" do
    violations = Chemicalml::Convention::UnitDictionary.validate(unit_list)
    expect(violations.length).to be > 0
  end

  it "UnitTypeDictionary flags a unitType missing its name in Schema24" do
    violations = Chemicalml::Convention::UnitTypeDictionary.validate(unit_type_list)
    name_violations = violations.select { |v| v.message.include?("name") }
    expect(name_violations.length).to eq(1)
    expect(name_violations.first.message).to match(/name/)
  end
end
