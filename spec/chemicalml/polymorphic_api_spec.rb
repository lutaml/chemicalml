# frozen_string_literal: true

require "spec_helper"
require "pathname"

RSpec.describe "polymorphic parse + translate" do
  let(:compchem_xml) do
    File.read(File.expand_path("../fixtures/schema3/compchem/h2_dft.cml", __dir__))
  end

  let(:molecular_xml) do
    File.read(File.expand_path("../fixtures/schema3/molecular/water.cml", __dir__))
  end

  describe "Chemicalml.parse root detection" do
    it "returns a Schema3 Module for <module>-rooted documents" do
      result = Chemicalml.parse(compchem_xml)
      expect(result).to be_a(Chemicalml::Cml::Schema3::Module)
    end

    it "preserves the jobList content under <module>" do
      result = Chemicalml.parse(compchem_xml)
      expect(result.modules.length).to eq(1)
      expect(result.modules.first.dict_ref).to eq("compchem:jobList")
      expect(result.modules.first.modules.length).to eq(1)
    end

    it "returns a Schema3 Document for <cml>-rooted documents" do
      result = Chemicalml.parse(molecular_xml)
      expect(result).to be_a(Chemicalml::Cml::Schema3::Document)
      expect(result.molecules.length).to eq(1)
    end

    it "raises ArgumentError for unknown root elements" do
      expect { Chemicalml.parse("<bogus/>") }
        .to raise_error(ArgumentError, /unsupported CML root element/)
    end

    it "raises ArgumentError when parsing <module> as Schema 2.4" do
      expect { Chemicalml.parse(compchem_xml, schema: :schema24) }
        .to raise_error(ArgumentError, /does not define Module/)
    end
  end

  describe "Translator.to_canonical polymorphism" do
    it "accepts a wire Document" do
      doc = Chemicalml.parse(molecular_xml)
      canonical = Chemicalml::Cml::Translator.to_canonical(doc)
      expect(canonical).to be_a(Chemicalml::Model::Document)
      expect(canonical.molecules.length).to eq(1)
    end

    it "accepts a wire Module" do
      mod = Chemicalml.parse(compchem_xml)
      canonical = Chemicalml::Cml::Translator.to_canonical(mod)
      expect(canonical).to be_a(Chemicalml::Model::Module)
      expect(canonical.modules.length).to eq(1)
    end

    it "raises ArgumentError for unknown input types" do
      expect { Chemicalml::Cml::Translator.to_canonical("not a node") }
        .to raise_error(ArgumentError, /accepts a wire Document or Module/)
    end
  end

  describe "Translator.from_canonical polymorphism" do
    it "accepts a canonical Document" do
      canonical_doc = Chemicalml::Model::Document.new(
        molecules: [Chemicalml::Model::Molecule.new(id: "m1")]
      )
      wire = Chemicalml::Cml::Translator.from_canonical(canonical_doc, schema: :schema3)
      expect(wire).to be_a(Chemicalml::Cml::Schema3::Document)
    end

    it "accepts a canonical Module" do
      canonical_mod = Chemicalml::Model::Module.new(
        dict_ref: "compchem:jobList",
        modules: [Chemicalml::Model::Module.new(dict_ref: "compchem:job")]
      )
      wire = Chemicalml::Cml::Translator.from_canonical(canonical_mod, schema: :schema3)
      expect(wire).to be_a(Chemicalml::Cml::Schema3::Module)
      expect(wire.modules.first.dict_ref).to eq("compchem:job")
    end

    it "raises ArgumentError for unknown input types" do
      expect { Chemicalml::Cml::Translator.from_canonical("not a node") }
        .to raise_error(ArgumentError, /accepts a canonical Document or Module/)
    end
  end

  describe "compchem round-trip" do
    it "round-trips wire → canonical → wire" do
      original = Chemicalml.parse(compchem_xml)
      canonical = Chemicalml::Cml::Translator.to_canonical(original)
      re_wire = Chemicalml::Cml::Translator.from_canonical(canonical, schema: :schema3)
      expect(re_wire).to be_a(Chemicalml::Cml::Schema3::Module)
      expect(re_wire.modules.first.dict_ref).to eq("compchem:jobList")
      expect(re_wire.modules.first.modules.first.dict_ref).to eq("compchem:job")
    end
  end
end
