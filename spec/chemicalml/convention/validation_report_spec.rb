# frozen_string_literal: true

require "spec_helper"

RSpec.describe Chemicalml::Convention::ValidationReport do
  let(:error) do
    Chemicalml::Convention::Violation.new(
      path: ["molecule"].join("/"),
      message: "missing id",
      severity: :error
    )
  end

  let(:warning) do
    Chemicalml::Convention::Violation.new(
      path: ["molecule"].join("/"),
      message: "namespace should end with /",
      severity: :warning
    )
  end

  it "exposes raw violations" do
    report = described_class.new([error, warning])
    expect(report.violations.length).to eq(2)
  end

  it "filters errors" do
    report = described_class.new([error, warning])
    expect(report.errors).to eq([error])
  end

  it "filters warnings" do
    report = described_class.new([error, warning])
    expect(report.warnings).to eq([warning])
  end

  it "ok? is true when no errors" do
    report = described_class.new([warning])
    expect(report).to be_ok
  end

  it "ok? is false when errors present" do
    report = described_class.new([error])
    expect(report).not_to be_ok
  end

  it "has_warnings? reflects warning presence" do
    expect(described_class.new([warning])).to have_warnings
    expect(described_class.new([error])).not_to have_warnings
  end

  it "combines two reports via +" do
    a = described_class.new([error])
    b = described_class.new([warning])
    combined = a + b
    expect(combined.violations).to eq([error, warning])
  end

  it "summarizes in to_s" do
    report = described_class.new([error, warning])
    expect(report.to_s).to eq("2 violation(s): 1 error(s), 1 warning(s)")
  end
end

RSpec.describe "Convention.validate_report / detect_and_validate" do
  it "validate_report returns a ValidationReport" do
    doc = Chemicalml::Cml::Schema3::Document.new(
      molecules: [Chemicalml::Cml::Schema3::Molecule.new(id: "m1")]
    )
    report = Chemicalml::Convention.validate_report(doc, qname: "convention:molecular")
    expect(report).to be_a(Chemicalml::Convention::ValidationReport)
  end

  it "detect_and_validate reads convention from document root" do
    doc = Chemicalml::Cml::Schema3::Molecule.new(
      id: "m1", convention: "convention:molecular",
      atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
        atoms: [Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "H")]
      )
    )
    report = Chemicalml::Convention.detect_and_validate(doc)
    expect(report).to be_a(Chemicalml::Convention::ValidationReport)
  end

  it "detect_and_validate raises when no convention declared" do
    doc = Chemicalml::Cml::Schema3::Document.new
    expect { Chemicalml::Convention.detect_and_validate(doc) }
      .to raise_error(ArgumentError, /declares no convention/)
  end
end
