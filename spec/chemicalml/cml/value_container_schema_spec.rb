# frozen_string_literal: true

require "spec_helper"

# Verifies that value containers (Scalar, Array, Matrix) and the
# Property / Parameter wrappers produce Schema24 classes when
# schema: :schema24 is requested — not just Schema3 with a Schema24
# wrapper.
RSpec.describe "value container schema-awareness" do
  let(:scalar_prop) do
    Chemicalml::Model::Property.new(
      dict_ref: "compchem:totalEnergy",
      title: "total energy",
      value: Chemicalml::Model::Scalar.new(
        value: "-1.0", data_type: "xsd:double", units: "nonsi:hartree"
      )
    )
  end

  let(:array_param) do
    Chemicalml::Model::Parameter.new(
      dict_ref: "compchem:coefficients",
      value: Chemicalml::Model::Array.new(
        values: %w[1.0 2.0 3.0], data_type: "xsd:double", size: "3"
      )
    )
  end

  it "Schema24 Property has Schema24 Scalar value" do
    wire = Chemicalml::Cml::Translator.property_from_canonical(scalar_prop, schema: :schema24)
    expect(wire.class).to be(Chemicalml::Cml::Schema24::Property)
    expect(wire.scalar.class).to be(Chemicalml::Cml::Schema24::Scalar)
  end

  it "Schema3 Property has Schema3 Scalar value (default)" do
    wire = Chemicalml::Cml::Translator.property_from_canonical(scalar_prop)
    expect(wire.class).to be(Chemicalml::Cml::Schema3::Property)
    expect(wire.scalar.class).to be(Chemicalml::Cml::Schema3::Scalar)
  end

  it "Schema24 Parameter has Schema24 Array value" do
    wire = Chemicalml::Cml::Translator.parameter_from_canonical(array_param, schema: :schema24)
    expect(wire.class).to be(Chemicalml::Cml::Schema24::Parameter)
    expect(wire.array.class).to be(Chemicalml::Cml::Schema24::Array)
  end

  it "scalar_from_canonical respects schema" do
    canonical = Chemicalml::Model::Scalar.new(value: "298.15", data_type: "xsd:double")
    wire24 = Chemicalml::Cml::Translator.scalar_from_canonical(canonical, schema: :schema24)
    expect(wire24.class).to be(Chemicalml::Cml::Schema24::Scalar)
  end

  it "label_from_canonical respects schema" do
    canonical = Chemicalml::Model::Label.new(value: "cc-pvdz", dict_ref: "compchem:basisSetLabel")
    wire24 = Chemicalml::Cml::Translator.label_from_canonical(canonical, schema: :schema24)
    expect(wire24.class).to be(Chemicalml::Cml::Schema24::Label)
  end

  it "formula_from_canonical respects schema" do
    canonical = Chemicalml::Model::Formula.new(concise: "C 1 H 4")
    wire24 = Chemicalml::Cml::Translator.formula_from_canonical(canonical, schema: :schema24)
    expect(wire24.class).to be(Chemicalml::Cml::Schema24::Formula)
  end
end
