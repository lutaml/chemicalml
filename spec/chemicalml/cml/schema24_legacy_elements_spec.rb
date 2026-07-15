# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Schema24 legacy elements (TODO-52)" do
  before do
    Chemicalml::Cml::Schema24::Configuration.ensure_registered!
  end

  it "Schema24 exposes Annotation" do
    expect(Chemicalml::Cml::Schema24.const_defined?(:Annotation, false)).to be(true)
    expect(Chemicalml::Cml::Schema24::Annotation.include?(Chemicalml::Cml::Role::Annotation))
      .to be(true)
  end

  it "Schema24 exposes Appinfo" do
    expect(Chemicalml::Cml::Schema24.const_defined?(:Appinfo, false)).to be(true)
    expect(Chemicalml::Cml::Schema24::Appinfo.include?(Chemicalml::Cml::Role::Appinfo))
      .to be(true)
  end

  it "Schema24 exposes Enumeration" do
    expect(Chemicalml::Cml::Schema24.const_defined?(:Enumeration, false)).to be(true)
    expect(Chemicalml::Cml::Schema24::Enumeration.include?(Chemicalml::Cml::Role::Enumeration))
      .to be(true)
  end

  it "Schema3 does NOT define these legacy elements" do
    Chemicalml::Cml::Schema3::Configuration.ensure_registered!
    expect(Chemicalml::Cml::Schema3.const_defined?(:Annotation, false)).to be(false)
    expect(Chemicalml::Cml::Schema3.const_defined?(:Appinfo, false)).to be(false)
    expect(Chemicalml::Cml::Schema3.const_defined?(:Enumeration, false)).to be(false)
  end

  it "WireClassRegistry raises ArgumentError when asking Schema3 for legacy element" do
    expect { Chemicalml::Cml::WireClassRegistry.for(:schema3, Chemicalml::Cml::Role::Annotation) }
      .to raise_error(ArgumentError, /does not define Annotation/)
  end

  it "parses a Schema24 document with <enumeration>" do
    xml = <<~XML
      <?xml version="1.0"?>
      <cml xmlns="http://www.xml-cml.org/schema">
        <enumeration value="open"/>
      </cml>
    XML
    parsed = Chemicalml.parse(xml, schema: :schema24)
    expect(parsed).to be_a(Chemicalml::Cml::Schema24::Document)
  end

  it "SCHEMA24_ONLY maps class names to XML element ids" do
    expect(Chemicalml::Cml::Elements::SCHEMA24_ONLY[:Annotation]).to eq(:annotation)
    expect(Chemicalml::Cml::Elements::SCHEMA24_ONLY[:Appinfo]).to eq(:appinfo)
    expect(Chemicalml::Cml::Elements::SCHEMA24_ONLY[:Enumeration]).to eq(:enumeration)
  end
end
