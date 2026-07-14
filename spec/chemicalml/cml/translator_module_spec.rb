# frozen_string_literal: true

require "spec_helper"

RSpec.describe Chemicalml::Cml::Translator do
  describe ".module_to_canonical / .module_from_canonical" do
    let(:wire_module) do
      Chemicalml::Cml::Schema3::Module.new(
        dict_ref: "compchem:jobList",
        id: "jl-1",
        title: "job list",
        modules: [
          Chemicalml::Cml::Schema3::Module.new(dict_ref: "compchem:job", id: "j-1")
        ]
      )
    end

    it "translates wire Module to canonical Model::Module" do
      canonical = described_class.module_to_canonical(wire_module)
      expect(canonical).to be_a(Chemicalml::Model::Module)
      expect(canonical.dict_ref).to eq("compchem:jobList")
      expect(canonical.id).to eq("jl-1")
      expect(canonical.modules.length).to eq(1)
      expect(canonical.modules.first.dict_ref).to eq("compchem:job")
    end

    it "produces Schema3 wire Module from canonical" do
      canonical = Chemicalml::Model::Module.new(
        dict_ref: "compchem:jobList",
        id: "jl-1",
        modules: [Chemicalml::Model::Module.new(dict_ref: "compchem:job", id: "j-1")]
      )
      wire = described_class.module_from_canonical(canonical, schema: :schema3)
      expect(wire.class).to be(Chemicalml::Cml::Schema3::Module)
      expect(wire.dict_ref).to eq("compchem:jobList")
      expect(wire.modules.first.class).to be(Chemicalml::Cml::Schema3::Module)
    end

    it "round-trips wire → canonical → wire" do
      canonical = described_class.module_to_canonical(wire_module)
      re_wire = described_class.module_from_canonical(canonical, schema: :schema3)
      expect(re_wire.dict_ref).to eq("compchem:jobList")
      expect(re_wire.modules.first.dict_ref).to eq("compchem:job")
    end
  end

  describe ".property_list_to_canonical / .property_list_from_canonical" do
    it "translates a property list with one scalar property" do
      wire = Chemicalml::Cml::Schema3::PropertyList.new(
        id: "pl-1",
        properties: [
          Chemicalml::Cml::Schema3::Property.new(
            dict_ref: "compchem:totalEnergy",
            scalar: Chemicalml::Cml::Schema3::Scalar.new(
              content: "-1.0", data_type: "xsd:double", units: "nonsi:hartree"
            )
          )
        ]
      )
      canonical = described_class.property_list_to_canonical(wire)
      expect(canonical).to be_a(Chemicalml::Model::PropertyList)
      expect(canonical.properties.length).to eq(1)
      expect(canonical.properties.first.dict_ref).to eq("compchem:totalEnergy")
    end
  end

  describe ".parameter_list_to_canonical / .parameter_list_from_canonical" do
    it "translates a parameter list" do
      wire = Chemicalml::Cml::Schema3::ParameterList.new(
        id: "paramlist-1",
        parameters: [
          Chemicalml::Cml::Schema3::Parameter.new(
            dict_ref: "compchem:method",
            scalar: Chemicalml::Cml::Schema3::Scalar.new(content: "dft", data_type: "xsd:string")
          )
        ]
      )
      canonical = described_class.parameter_list_to_canonical(wire)
      expect(canonical.parameters.length).to eq(1)
      expect(canonical.parameters.first.dict_ref).to eq("compchem:method")
    end
  end

  describe ".metadata_list_to_canonical / .metadata_list_from_canonical" do
    it "translates a metadata list" do
      wire = Chemicalml::Cml::Schema3::MetadataList.new(
        metadata: [
          Chemicalml::Cml::Schema3::Metadata.new(name: "dc:creator", content: "joe")
        ]
      )
      canonical = described_class.metadata_list_to_canonical(wire)
      expect(canonical.metadata.first.name).to eq("dc:creator")
      expect(canonical.metadata.first.content).to eq("joe")
    end
  end
end
