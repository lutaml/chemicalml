# frozen_string_literal: true

require "spec_helper"

RSpec.describe Chemicalml::Schema::Registry do
  it "lists both schema versions" do
    expect(described_class.versions).to contain_exactly(:schema24, :schema3)
  end

  it "looks up by symbol, string, or version" do
    expect(described_class.lookup(:schema3).version).to eq(:schema3)
    expect(described_class.lookup("schema3").version).to eq(:schema3)
    expect(described_class.lookup("schema24").version).to eq(:schema24)
  end

  it "defaults to schema3" do
    expect(described_class.default.version).to eq(:schema3)
  end

  it "raises ArgumentError on unknown version" do
    expect { described_class.lookup(:schema99) }
      .to raise_error(ArgumentError, /unknown schema version/)
  end

  it "points the XSD paths at reference-docs/" do
    expect(described_class.lookup(:schema24).xsd_path)
      .to eq("reference-docs/schemas/schema24/schema.xsd")
    expect(described_class.lookup(:schema3).xsd_path)
      .to eq("reference-docs/schemas/schema3/schema.xsd")
  end
end

RSpec.describe Chemicalml::Schema::Definition do
  let(:defn) { Chemicalml::Schema::Registry.lookup(:schema3) }

  it "exposes its metadata" do
    expect(defn.version).to eq(:schema3)
    expect(defn.xml_namespace).to eq("http://www.xml-cml.org/schema")
    expect(defn.ruby_namespace).to eq("Chemicalml::Cml::Schema3")
  end

  it "is frozen" do
    expect(defn).to be_frozen
  end

  it "resolves the wire-class constant" do
    expect(defn.wire_namespace_constant).to eq(Chemicalml::Cml::Schema3)
  end
end

RSpec.describe Chemicalml::Cml::Schema3 do
  it "is the same Document class as Chemicalml::Cml::Document" do
    expect(described_class::Document).to be(Chemicalml::Cml::Document)
  end

  it "is the same Molecule class as Chemicalml::Cml::Molecule" do
    expect(described_class::Molecule).to be(Chemicalml::Cml::Molecule)
  end

  it "exposes its schema definition" do
    expect(described_class.schema.version).to eq(:schema3)
  end
end

RSpec.describe Chemicalml::Cml::Schema24 do
  it "is a distinct class hierarchy from Schema3" do
    expect(described_class::Document).not_to be(Chemicalml::Cml::Schema3::Document)
  end

  it "exposes its schema definition" do
    expect(described_class.schema.version).to eq(:schema24)
  end

  it "registers its wire classes in its own lutaml context" do
    expect(described_class::Configuration.context_id)
      .to eq(:chemicalml_schema24)
  end
end
