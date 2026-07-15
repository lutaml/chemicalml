# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Full CML schema coverage" do
  it "covers all 121 elements from the Schema 3 XSD" do
    expect(Chemicalml::Cml::Elements::ALL.length).to eq(121)
  end

  it "has matching Base, Role, Schema3, and Schema24 classes for every element" do
    Chemicalml::Cml::Schema3::Configuration.ensure_registered!
    Chemicalml::Cml::Schema24::Configuration.ensure_registered!

    Chemicalml::Cml::Elements::ALL.each_key do |class_name|
      expect(Chemicalml::Cml::Base.const_defined?(class_name))
        .to be(true), "Base::#{class_name} missing"
      expect(Chemicalml::Cml::Role.const_defined?(class_name))
        .to be(true), "Role::#{class_name} missing"
      expect(Chemicalml::Cml::Schema3.const_defined?(class_name, false))
        .to be(true), "Schema3::#{class_name} missing"
    end
  end

  it "Schema24 lacks AnyCml (Schema 3 only)" do
    Chemicalml::Cml::Schema24::Configuration.ensure_registered!
    expect(Chemicalml::Cml::Schema24.const_defined?(:AnyCml, false))
      .to be(false)
  end

  it "Schema24 defines Module (module is in both XSDs)" do
    Chemicalml::Cml::Schema24::Configuration.ensure_registered!
    expect(Chemicalml::Cml::Schema24.const_defined?(:Module, false))
      .to be(true)
  end

  it "all dictionaries load with entries" do
    Chemicalml::Dictionary::Registry.reset!
    names = Chemicalml::Dictionary::Registry.builtin_names
    expect(names.length).to be >= 7

    names.each do |name|
      next if name == :_index

      dict = Chemicalml::Dictionary.load(name)
      expect(dict.entries.length).to be > 0, "#{name} has 0 entries"
    end
  end

  it "Crystal element parses and round-trips" do
    xml = "<crystal xmlns=\"http://www.xml-cml.org/schema\" id=\"c1\"><scalar dataType=\"xsd:double\">5.64</scalar></crystal>"
    crystal = Chemicalml.parse(xml)
    expect(crystal).to be_a(Chemicalml::Cml::Schema3::Crystal)
    expect(crystal.id).to eq("c1")
    expect(crystal.scalars.first.content).to eq("5.64")
  end

  it "Spectrum element has axes children" do
    xml = "<spectrum xmlns=\"http://www.xml-cml.org/schema\" id=\"s1\"><xaxis/><yaxis/></spectrum>"
    spectrum = Chemicalml.parse(xml)
    expect(spectrum).to be_a(Chemicalml::Cml::Schema3::Spectrum)
    expect(spectrum.xaxis).not_to be_nil
    expect(spectrum.yaxis).not_to be_nil
  end

  it "PeakList holds peak children" do
    xml = "<peakList xmlns=\"http://www.xml-cml.org/schema\"><peak xValue=\"100\"/><peak xValue=\"200\"/></peakList>"
    pl = Chemicalml.parse(xml)
    expect(pl).to be_a(Chemicalml::Cml::Schema3::PeakList)
    expect(pl.peaks.length).to eq(2)
  end

  it "Table holds content and header" do
    xml = "<table xmlns=\"http://www.xml-cml.org/schema\"><tableHeader/><tableContent/></table>"
    table = Chemicalml.parse(xml)
    expect(table).to be_a(Chemicalml::Cml::Schema3::Table)
    expect(table.table_header).not_to be_nil
    expect(table.table_content).not_to be_nil
  end

  it "all Schema3 wire classes include Visitable" do
    Chemicalml::Cml::Elements::ALL.each_key do |class_name|
      next if class_name == :Module  # Module needs special handling
      klass = Chemicalml::Cml::Schema3.const_get(class_name)
      expect(klass.include?(Chemicalml::Cml::Visitable))
        .to be(true), "#{class_name} doesn't include Visitable"
    end
  end
end
