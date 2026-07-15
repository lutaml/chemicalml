# frozen_string_literal: true

require "spec_helper"

RSpec.describe "unitType-dictionary convention TODO-40 constraints" do
  let(:list_class) { Chemicalml::Cml::Schema3::UnitTypeList }
  let(:unit_type_class) { Chemicalml::Cml::Schema3::UnitType }

  def validate(node)
    Chemicalml::Convention::UnitTypeDictionary.validate(node)
  end

  def valid_unit_type(overrides = {})
    unit_type_class.new({ id: "ut1", name: "length", definition: "distance metric" }
                          .merge(overrides))
  end

  describe "UnitTypeIdMustMatchPattern" do
    it "flags a unitType id starting with a digit" do
      list = list_class.new(namespace: "http://example.org/#",
                            unit_types: [valid_unit_type(id: "1bad")])
      violations = validate(list)
      expect(violations.map(&:message))
        .to include(match(/unitType id "1bad" must match/))
    end

    it "passes a well-formed id" do
      list = list_class.new(namespace: "http://example.org/#",
                            unit_types: [valid_unit_type(id: "good-id")])
      violations = validate(list)
      expect(violations.map(&:message))
        .not_to include(match(/unitType id/))
    end
  end

  describe "UnitTypeMustContainDefinition" do
    it "flags a unitType without definition" do
      list = list_class.new(namespace: "http://example.org/#",
                            unit_types: [valid_unit_type(definition: nil)])
      violations = validate(list)
      expect(violations.map(&:message))
        .to include(match(/unitType "ut1" must contain a single definition child/))
    end
  end

  describe "UnitTypeListMustHaveNamespace" do
    it "flags a unitTypeList without namespace" do
      list = list_class.new(unit_types: [valid_unit_type])
      violations = validate(list)
      expect(violations.map(&:message))
        .to include(match(/unitTypeList must have a namespace attribute/))
    end

    it "warns when namespace doesn't end with / or #" do
      list = list_class.new(namespace: "http://example.org/abc",
                            unit_types: [valid_unit_type])
      violations = validate(list)
      ns_warning = violations.find { |v| v.message.include?("should end with / or #") }
      expect(ns_warning).not_to be_nil
      expect(ns_warning).to be_warning
    end
  end

  describe "UnitTypeListMustContainAtLeastOneUnitType" do
    it "flags an empty unitTypeList" do
      list = list_class.new(namespace: "http://example.org/#", unit_types: [])
      violations = validate(list)
      expect(violations.map(&:message))
        .to include(match(/unitTypeList must contain at least one unitType child/))
    end
  end

  it "registers 5 unitType-dictionary constraints" do
    expect(Chemicalml::Convention::UnitTypeDictionary.constraint_count).to eq(5)
  end
end
