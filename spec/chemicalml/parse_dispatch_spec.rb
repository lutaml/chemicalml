# frozen_string_literal: true

require "spec_helper"

RSpec.describe Chemicalml::Cml::Translator do
  describe ".from_canonical schema dispatch" do
    let(:canonical_doc) do
      Chemicalml::Model::Document.new(
        molecules: [
          Chemicalml::Model::Molecule.new(
            id: "m1",
            atoms: [
              Chemicalml::Model::Atom.new(id: "a1", element: "H"),
              Chemicalml::Model::Atom.new(id: "a2", element: "O")
            ],
            bonds: [
              Chemicalml::Model::Bond.new(id: "b1", atom_refs: %w[a1 a2], kind: :single)
            ]
          )
        ]
      )
    end

    it "defaults to Schema3" do
      wire = described_class.from_canonical(canonical_doc)
      expect(wire.class).to be(Chemicalml::Cml::Schema3::Document)
    end

    it "produces a Schema24 document when schema: :schema24" do
      wire = described_class.from_canonical(canonical_doc, schema: :schema24)
      expect(wire.class).to be(Chemicalml::Cml::Schema24::Document)
    end

    it "produces a Schema3 document when schema: :schema3" do
      wire = described_class.from_canonical(canonical_doc, schema: :schema3)
      expect(wire.class).to be(Chemicalml::Cml::Schema3::Document)
    end

    it "raises ArgumentError on unknown schema" do
      expect { described_class.from_canonical(canonical_doc, schema: :bogus) }
        .to raise_error(ArgumentError, /unsupported schema/)
    end

    it "round-trips through Schema24 wire -> canonical -> Schema24 wire" do
      wire24 = described_class.from_canonical(canonical_doc, schema: :schema24)
      canonical_again = described_class.to_canonical(wire24)
      expect(canonical_again.molecules.first.atoms.map(&:element))
        .to eq(%w[H O])
    end
  end
end

RSpec.describe Chemicalml do
  describe ".parse / .serialize" do
    it "dispatches to Schema3 by default" do
      xml = "<cml><molecule id=\"m1\"><atomArray><atom id=\"a1\" elementType=\"C\"/></atomArray></molecule></cml>"
      doc = described_class.parse(xml)
      expect(doc.class).to be(Chemicalml::Cml::Schema3::Document)
      expect(described_class.serialize(doc)).to include("elementType=\"C\"")
    end

    it "dispatches to Schema24 explicitly" do
      xml = "<cml><molecule id=\"m1\"><atomArray><atom id=\"a1\" elementType=\"C\"/></atomArray></molecule></cml>"
      doc = described_class.parse(xml, schema: :schema24)
      expect(doc.class).to be(Chemicalml::Cml::Schema24::Document)
    end

    it "raises ArgumentError on unknown schema" do
      expect { described_class.parse("<cml/>", schema: :bogus) }
        .to raise_error(ArgumentError, /unsupported schema/)
    end

    it "parses via Cml::Schema3.parse directly" do
      xml = "<cml><molecule id=\"m1\"><atomArray><atom id=\"a1\" elementType=\"N\"/></atomArray></molecule></cml>"
      doc = Chemicalml::Cml::Schema3.parse(xml)
      expect(doc.molecules.first.atom_array.atoms.first.element_type).to eq("N")
    end
  end
end
