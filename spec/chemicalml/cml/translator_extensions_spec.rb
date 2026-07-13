# frozen_string_literal: true

require "spec_helper"

RSpec.describe Chemicalml::Cml::Translator do
  describe ".scalar_to_canonical / .scalar_from_canonical" do
    it "round-trips value + dataType + units" do
      wire = Chemicalml::Cml::Scalar.new(
        content: "298.15", data_type: "xsd:double", units: "si:K"
      )
      canonical = described_class.scalar_to_canonical(wire)
      expect(canonical.value).to eq("298.15")
      expect(canonical.data_type).to eq("xsd:double")
      re = described_class.scalar_from_canonical(canonical)
      expect(re.content).to eq("298.15")
      expect(re.units).to eq("si:K")
    end
  end

  describe ".array_to_canonical / .array_from_canonical" do
    it "round-trips space-separated values + size" do
      wire = Chemicalml::Cml::Array.new(
        content: "1.0 2.0 3.0", data_type: "xsd:double", size: "3"
      )
      canonical = described_class.array_to_canonical(wire)
      expect(canonical.values).to eq(%w[1.0 2.0 3.0])
      expect(canonical.size).to eq("3")
      re = described_class.array_from_canonical(canonical)
      expect(re.content).to eq("1.0 2.0 3.0")
    end
  end

  describe ".matrix_to_canonical / .matrix_from_canonical" do
    it "round-trips rows + columns" do
      wire = Chemicalml::Cml::Matrix.new(
        content: "1 0 0 0 1 0 0 0 1",
        data_type: "xsd:double", rows: "3", columns: "3"
      )
      canonical = described_class.matrix_to_canonical(wire)
      expect(canonical.rows).to eq("3")
      expect(canonical.columns).to eq("3")
      re = described_class.matrix_from_canonical(canonical)
      expect(re.content).to eq("1 0 0 0 1 0 0 0 1")
    end
  end

  describe ".property_to_canonical / .property_from_canonical" do
    it "carries the scalar value through dictRef" do
      wire = Chemicalml::Cml::Property.new(
        dict_ref: "compchem:totalEnergy",
        title: "total energy",
        scalar: Chemicalml::Cml::Scalar.new(
          content: "-38.887", data_type: "xsd:double", units: "nonsi:hartree"
        )
      )
      canonical = described_class.property_to_canonical(wire)
      expect(canonical.dict_ref).to eq("compchem:totalEnergy")
      expect(canonical.value.value).to eq("-38.887")

      re = described_class.property_from_canonical(canonical)
      expect(re.dict_ref).to eq("compchem:totalEnergy")
      expect(re.scalar.content).to eq("-38.887")
    end
  end

  describe ".parameter_to_canonical / .parameter_from_canonical" do
    it "carries the scalar input through dictRef" do
      wire = Chemicalml::Cml::Parameter.new(
        dict_ref: "compchem:method",
        scalar: Chemicalml::Cml::Scalar.new(content: "dft", data_type: "xsd:string")
      )
      canonical = described_class.parameter_to_canonical(wire)
      expect(canonical.dict_ref).to eq("compchem:method")
      expect(canonical.value.value).to eq("dft")
    end
  end

  describe ".label_to_canonical / .label_from_canonical" do
    it "round-trips value + dictRef" do
      wire = Chemicalml::Cml::Label.new(value: "cc-pvdz",
                                        dict_ref: "compchem:basisSetLabel")
      canonical = described_class.label_to_canonical(wire)
      expect(canonical.value).to eq("cc-pvdz")
      expect(canonical.dict_ref).to eq("compchem:basisSetLabel")
    end
  end

  describe ".metadata_to_canonical / .metadata_from_canonical" do
    it "round-trips name + content" do
      wire = Chemicalml::Cml::Metadata.new(name: "dc:creator", content: "joe")
      canonical = described_class.metadata_to_canonical(wire)
      expect(canonical.name).to eq("dc:creator")
      expect(canonical.content).to eq("joe")
    end
  end

  describe ".formula_to_canonical / .formula_from_canonical" do
    it "round-trips concise + inline" do
      wire = Chemicalml::Cml::Formula.new(concise: "C 1 H 4 O 1",
                                          inline: "H_{3}C-OH")
      canonical = described_class.formula_to_canonical(wire)
      expect(canonical.concise).to eq("C 1 H 4 O 1")
      expect(canonical.inline).to eq("H_{3}C-OH")
    end
  end
end

RSpec.describe Chemicalml::Model::Property do
  it "exposes children for traversal" do
    p = described_class.new(
      dict_ref: "compchem:x",
      value: Chemicalml::Model::Scalar.new(value: "1.0")
    )
    expect(p.children.length).to eq(1)
  end
end

RSpec.describe Chemicalml::Model::Module do
  it "aggregates children across collections" do
    m = described_class.new(
      dict_ref: "compchem:job",
      molecules: [Chemicalml::Model::Molecule.new],
      modules: [described_class.new(dict_ref: "compchem:initialization")]
    )
    expect(m.children.length).to eq(2)
  end
end
