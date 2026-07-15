# frozen_string_literal: true

require "spec_helper"

RSpec.describe "dictionary convention TODO-38 constraints" do
  let(:dict_class) { Chemicalml::Cml::Schema3::Dictionary }
  let(:entry_class) { Chemicalml::Cml::Schema3::DictionaryEntry }

  def validate(node)
    Chemicalml::Convention::Dictionary.validate(node)
  end

  def valid_entry(overrides = {})
    entry_class.new({ id: "e1", term: "Energy", definition: "capacity to do work",
                      unit_type: "energy" }.merge(overrides))
  end

  describe "DictionaryMustHaveNamespace" do
    it "flags a dictionary without namespace" do
      dict = dict_class.new(entries: [valid_entry])
      violations = validate(dict)
      expect(violations.map(&:message))
        .to include(match(/dictionary must have a namespace attribute/))
    end

    it "passes when namespace is present" do
      dict = dict_class.new(namespace: "http://example.org/#", entries: [valid_entry])
      violations = validate(dict)
      expect(violations.map(&:message))
        .not_to include(match(/dictionary must have a namespace/))
    end
  end

  describe "DictionaryNamespaceShouldEndWithSlashOrHash" do
    it "warns when namespace doesn't end with / or #" do
      dict = dict_class.new(namespace: "http://example.org/abc", entries: [valid_entry])
      violations = validate(dict)
      warning = violations.find { |v| v.message.include?("should end with / or #") }
      expect(warning).not_to be_nil
      expect(warning).to be_warning
    end

    it "is silent when namespace ends with /" do
      dict = dict_class.new(namespace: "http://example.org/", entries: [valid_entry])
      violations = validate(dict)
      expect(violations.map(&:message))
        .not_to include(match(/should end with/))
    end
  end

  describe "EntryMustContainDefinition" do
    it "flags an entry without definition" do
      dict = dict_class.new(
        namespace: "http://example.org/#",
        entries: [entry_class.new(id: "x", term: "T", unit_type: "none")]
      )
      violations = validate(dict)
      expect(violations.map(&:message))
        .to include(match(/entry "x" must contain a single definition child/))
    end
  end

  describe "EntryIdMustMatchPattern" do
    it "flags an entry id starting with a digit" do
      dict = dict_class.new(
        namespace: "http://example.org/#",
        entries: [entry_class.new(id: "1bad", term: "T", definition: "x",
                                  unit_type: "none")]
      )
      violations = validate(dict)
      expect(violations.map(&:message))
        .to include(match(/entry id "1bad" must match/))
    end

    it "passes a well-formed id" do
      dict = dict_class.new(
        namespace: "http://example.org/#",
        entries: [entry_class.new(id: "good-id.1_2", term: "T", definition: "x",
                                  unit_type: "none")]
      )
      violations = validate(dict)
      expect(violations.map(&:message))
        .not_to include(match(/entry id "good-id.1_2" must match/))
    end
  end

  describe "EntryMustHaveUnitType" do
    it "flags an entry without unitType" do
      dict = dict_class.new(
        namespace: "http://example.org/#",
        entries: [entry_class.new(id: "x", term: "T", definition: "x")]
      )
      violations = validate(dict)
      expect(violations.map(&:message))
        .to include(match(/entry "x" must have a unitType attribute/))
    end
  end

  describe "EntryUnitsCoConstraints" do
    it "flags unitType=unknown with units present" do
      dict = dict_class.new(
        namespace: "http://example.org/#",
        entries: [entry_class.new(id: "x", term: "T", definition: "x",
                                  unit_type: "unknown", units: "si:m")]
      )
      violations = validate(dict)
      expect(violations.map(&:message))
        .to include(match(/unitType 'unknown'.*must not have units/))
    end

    it "flags unitType=none without units pointing to si#none" do
      dict = dict_class.new(
        namespace: "http://example.org/#",
        entries: [entry_class.new(id: "x", term: "T", definition: "x",
                                  unit_type: "none", units: "si:m")]
      )
      violations = validate(dict)
      expect(violations.map(&:message))
        .to include(match(/units must be/))
    end

    it "passes unitType=none with units=si#none" do
      dict = dict_class.new(
        namespace: "http://example.org/#",
        entries: [entry_class.new(id: "x", term: "T", definition: "x",
                                  unit_type: "none",
                                  units: "http://www.xml-cml.org/unit/si#none")]
      )
      violations = validate(dict)
      expect(violations.map(&:message))
        .not_to include(match(/unitType 'none'/))
    end
  end

  it "registers 8 dictionary constraints" do
    expect(Chemicalml::Convention::Dictionary.constraint_count).to eq(8)
  end
end
