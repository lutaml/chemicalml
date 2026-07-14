# frozen_string_literal: true

require "spec_helper"

RSpec.describe Chemicalml::Convention::Violation do
  it "carries path + message + severity + constraint" do
    v = described_class.new(path: "molecule[m1]", message: "bad",
                            severity: :warning, constraint: SomeConstraint)
    expect(v.path).to eq("molecule[m1]")
    expect(v.message).to eq("bad")
    expect(v).to be_warning
    expect(v.constraint).to eq(SomeConstraint)
  end

  it "defaults severity to error" do
    expect(described_class.new(path: "x", message: "y")).to be_error
  end

  it "rejects unknown severities" do
    expect { described_class.new(path: "x", message: "y", severity: :bogus) }
      .to raise_error(ArgumentError, /unknown severity/)
  end

  it "is frozen" do
    expect(described_class.new(path: "x", message: "y")).to be_frozen
  end
end

RSpec.describe Chemicalml::Convention::Registry do
  it "lists all five built-in conventions" do
    expect(described_class.builtin_qnames).to contain_exactly(
      "convention:molecular",
      "convention:compchem",
      "convention:dictionary",
      "convention:unit-dictionary",
      "convention:unitType-dictionary"
    )
  end

  it "looks up a convention by QName" do
    expect(described_class.lookup("convention:molecular"))
      .to be(Chemicalml::Convention::Molecular)
  end

  it "raises ArgumentError on unknown QName" do
    expect { described_class.validate(nil, qname: "convention:nope") }
      .to raise_error(ArgumentError, /unknown convention/)
  end
end

RSpec.describe Chemicalml::Convention::Molecular do
  it "registers three constraints" do
    expect(described_class.constraint_count).to eq(13)
  end

  it "exposes its QName and namespace URI" do
    expect(described_class.qname).to eq("convention:molecular")
    expect(described_class.namespace_uri)
      .to eq("http://www.xml-cml.org/convention/molecular")
  end

  it "flags duplicate atom ids" do
    doc = Chemicalml::Cml::Document.new(
      molecules: [
        Chemicalml::Cml::Molecule.new(
          id: "m1",
          atom_array: Chemicalml::Cml::AtomArray.new(
            atoms: [
              Chemicalml::Cml::Atom.new(id: "a1", element_type: "H"),
              Chemicalml::Cml::Atom.new(id: "a1", element_type: "O")
            ]
          )
        )
      ]
    )
    violations = described_class.validate(doc)
    expect(violations.length).to eq(1)
    expect(violations.first.message).to match(/duplicate atom id/)
  end

  it "flags an empty atomArray" do
    doc = Chemicalml::Cml::Document.new(
      molecules: [
        Chemicalml::Cml::Molecule.new(
          id: "m1",
          atom_array: Chemicalml::Cml::AtomArray.new(atoms: [])
        )
      ]
    )
    violations = described_class.validate(doc)
    expect(violations.length).to eq(1)
    expect(violations.first.message).to match(/at least one atom/)
  end

  it "flags a bond that references atoms outside its molecule" do
    doc = Chemicalml::Cml::Document.new(
      molecules: [
        Chemicalml::Cml::Molecule.new(
          id: "m1",
          atom_array: Chemicalml::Cml::AtomArray.new(
            atoms: [Chemicalml::Cml::Atom.new(id: "a1", element_type: "C")]
          ),
          bond_array: Chemicalml::Cml::BondArray.new(
            bonds: [Chemicalml::Cml::Bond.new(id: "b1", atom_refs2: "a1 a99", order: "S")]
          )
        )
      ]
    )
    violations = described_class.validate(doc)
    expect(violations.length).to eq(1)
    expect(violations.first.message).to match(/not in the same molecule/)
  end

  it "passes a clean document" do
    doc = Chemicalml::Cml::Document.new(
      molecules: [
        Chemicalml::Cml::Molecule.new(
          id: "m1",
          atom_array: Chemicalml::Cml::AtomArray.new(
            atoms: [
              Chemicalml::Cml::Atom.new(id: "a1", element_type: "H"),
              Chemicalml::Cml::Atom.new(id: "a2", element_type: "O")
            ]
          ),
          bond_array: Chemicalml::Cml::BondArray.new(
            bonds: [Chemicalml::Cml::Bond.new(id: "b1", atom_refs2: "a1 a2", order: "S")]
          )
        )
      ]
    )
    expect(described_class.validate(doc)).to be_empty
  end
end

RSpec.describe Chemicalml::Convention::Compchem do
  it "flags a compchem module without a jobList" do
    doc = Chemicalml::Cml::Module.new(
      convention: "convention:compchem",
      modules: []
    )
    violations = described_class.validate(doc)
    expect(violations.length).to eq(1)
    expect(violations.first.message).to match(/jobList/)
  end

  it "flags a job without an initialization module" do
    doc = Chemicalml::Cml::Module.new(
      convention: "convention:compchem",
      modules: [
        Chemicalml::Cml::Module.new(dict_ref: "compchem:jobList",
                                    modules: [
                                      Chemicalml::Cml::Module.new(dict_ref: "compchem:job")
                                    ])
      ]
    )
    violations = described_class.validate(doc)
    expect(violations.length).to eq(1)
    expect(violations.first.message).to match(/initialization/)
  end
end

RSpec.describe Chemicalml::Convention::Dictionary do
  it "flags an entry missing its term" do
    doc = Chemicalml::Cml::Dictionary.new(
      namespace: "http://example.org/",
      entries: [
        Chemicalml::Cml::DictionaryEntry.new(id: "foo", term: nil)
      ]
    )
    violations = described_class.validate(doc)
    expect(violations.length).to eq(1)
    expect(violations.first.message).to match(/term/)
  end

  it "flags duplicate entry ids" do
    doc = Chemicalml::Cml::Dictionary.new(
      namespace: "http://example.org/",
      entries: [
        Chemicalml::Cml::DictionaryEntry.new(id: "dup", term: "First"),
        Chemicalml::Cml::DictionaryEntry.new(id: "dup", term: "Second")
      ]
    )
    violations = described_class.validate(doc)
    expect(violations.length).to eq(1)
    expect(violations.first.message).to match(/duplicate entry id/)
  end
end

RSpec.describe Chemicalml::Convention::UnitDictionary do
  it "flags a unit missing required attributes" do
    doc = Chemicalml::Cml::UnitList.new(
      namespace: "http://example.org/",
      units: [
        Chemicalml::Cml::Unit.new(id: "broken")
      ]
    )
    violations = described_class.validate(doc)
    expect(violations.length).to be > 0
    messages = violations.map(&:message).join("\n")
    expect(messages).to match(/title/)
    expect(messages).to match(/symbol/)
    expect(messages).to match(/parent_si/)
    expect(messages).to match(/unit_type/)
    expect(messages).to match(/multiplierToSI|constantToSI/)
  end

  it "passes a fully-specified unit" do
    doc = Chemicalml::Cml::UnitList.new(
      namespace: "http://example.org/",
      units: [
        Chemicalml::Cml::Unit.new(
          id: "s", title: "second", symbol: "s",
          parent_si: "siUnits:s", multiplier_to_si: "1",
          constant_to_si: "0", unit_type: "unitType:time"
        )
      ]
    )
    expect(described_class.validate(doc)).to be_empty
  end
end

RSpec.describe Chemicalml::Convention::UnitTypeDictionary do
  it "flags a unitType missing its name" do
    doc = Chemicalml::Cml::UnitTypeList.new(
      namespace: "http://example.org/",
      unit_types: [
        Chemicalml::Cml::UnitType.new(id: "x")
      ]
    )
    violations = described_class.validate(doc)
    expect(violations.length).to eq(1)
    expect(violations.first.message).to match(/name/)
  end
end

class SomeConstraint < Chemicalml::Convention::Constraint; end
