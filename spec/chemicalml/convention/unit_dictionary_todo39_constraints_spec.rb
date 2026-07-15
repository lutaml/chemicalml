# frozen_string_literal: true

require "spec_helper"

RSpec.describe "unit-dictionary convention TODO-39 constraints" do
  let(:list_class) { Chemicalml::Cml::Schema3::UnitList }
  let(:unit_class) { Chemicalml::Cml::Schema3::Unit }

  def validate(node)
    Chemicalml::Convention::UnitDictionary.validate(node)
  end

  def valid_unit(overrides = {})
    unit_class.new({
      id: "u1", title: "joule", symbol: "J",
      parent_si: "si:j", multiplier_to_si: "1",
      unit_type: "ut:energy", definition: "SI derived unit of energy"
    }.merge(overrides))
  end

  describe "UnitMustHaveId" do
    it "flags a unit without id" do
      list = list_class.new(namespace: "http://example.org/#",
                            units: [unit_class.new(title: "T", symbol: "S",
                                                   parent_si: "si:x", multiplier_to_si: "1",
                                                   unit_type: "ut:x", definition: "y")])
      violations = validate(list)
      expect(violations.map(&:message))
        .to include(match(/unit must have an id attribute/))
    end
  end

  describe "UnitMustContainDefinition" do
    it "flags a unit without definition" do
      list = list_class.new(namespace: "http://example.org/#",
                            units: [valid_unit(definition: nil)])
      violations = validate(list)
      expect(violations.map(&:message))
        .to include(match(/unit "u1" must contain a single definition child/))
    end
  end

  describe "UnitListMustHaveNamespace" do
    it "flags a unitList without namespace" do
      list = list_class.new(units: [valid_unit])
      violations = validate(list)
      expect(violations.map(&:message))
        .to include(match(/unitList must have a namespace attribute/))
    end

    it "warns when namespace doesn't end with / or #" do
      list = list_class.new(namespace: "http://example.org/abc",
                            units: [valid_unit])
      violations = validate(list)
      ns_warning = violations.find { |v| v.message.include?("should end with / or #") }
      expect(ns_warning).not_to be_nil
      expect(ns_warning).to be_warning
    end
  end

  describe "UnitListMustContainAtLeastOneUnit" do
    it "flags an empty unitList" do
      list = list_class.new(namespace: "http://example.org/#", units: [])
      violations = validate(list)
      expect(violations.map(&:message))
        .to include(match(/unitList must contain at least one unit child/))
    end
  end

  it "registers 5 unit-dictionary constraints" do
    expect(Chemicalml::Convention::UnitDictionary.constraint_count).to eq(5)
  end
end
