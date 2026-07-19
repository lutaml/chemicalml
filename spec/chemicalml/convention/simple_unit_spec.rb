# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'simpleUnit convention constraints' do
  let(:unit_class)   { Chemicalml::Cml::Schema3::Unit }
  let(:list_class)   { Chemicalml::Cml::Schema3::UnitList }

  def validate(node)
    Chemicalml::Convention::SimpleUnit.validate(node)
  end

  describe 'registration' do
    it 'is registered under its QName' do
      expect(Chemicalml::Convention.lookup('convention:simpleUnit'))
        .to eq(Chemicalml::Convention::SimpleUnit)
    end

    it 'exposes the convention namespace' do
      expect(Chemicalml::Convention::SimpleUnit.namespace_uri)
        .to eq('http://www.xml-cml.org/convention/simpleUnit')
    end
  end

  describe 'RootMustBeUnitList' do
    it 'flags a document whose root is not a unitList' do
      unit = unit_class.new(id: 'u1', symbol: 'J', power: '1')
      violations = validate(unit)
      expect(violations.map(&:message))
        .to include(match(/simpleUnit root must be <unitList>/))
    end

    it 'passes when the root is a unitList declaring simpleUnit convention' do
      list = list_class.new(
        convention: 'convention:simpleUnit',
        units: [unit_class.new(id: 'u1', symbol: 'J', power: '1')]
      )
      violations = validate(list)
      expect(violations.map(&:message))
        .not_to include(match(/simpleUnit root must be/))
    end

    it 'flags a unitList that does not declare simpleUnit convention' do
      list = list_class.new(
        convention: 'convention:unit-dictionary',
        units: [unit_class.new(id: 'u1', symbol: 'J', power: '1')]
      )
      violations = validate(list)
      expect(violations.map(&:message))
        .to include(match(/simpleUnit root must be/))
    end
  end

  describe 'UnitMustHavePower' do
    let(:list) do
      list_class.new(
        convention: 'convention:simpleUnit',
        units: [unit_class.new(id: 'u1', symbol: 'J', power: power)]
      )
    end

    it 'flags a unit without power' do
      nil
      list = list_class.new(
        convention: 'convention:simpleUnit',
        units: [unit_class.new(id: 'u1', symbol: 'J')]
      )
      violations = validate(list)
      expect(violations.map(&:message))
        .to include(match(/unit .* must declare a power attribute/))
    end

    it 'passes when power is present' do
      list = list_class.new(
        convention: 'convention:simpleUnit',
        units: [unit_class.new(id: 'u1', symbol: 'J', power: '2')]
      )
      violations = validate(list)
      expect(violations.map(&:message))
        .not_to include(match(/must declare a power attribute/))
    end
  end

  describe 'UnitMustHaveSymbol' do
    it 'flags a unit without symbol' do
      list = list_class.new(
        convention: 'convention:simpleUnit',
        units: [unit_class.new(id: 'u1', power: '1')]
      )
      violations = validate(list)
      expect(violations.map(&:message))
        .to include(match(/unit .* must declare a non-empty symbol attribute/))
    end

    it 'passes when symbol is present' do
      list = list_class.new(
        convention: 'convention:simpleUnit',
        units: [unit_class.new(id: 'u1', symbol: 'J', power: '1')]
      )
      violations = validate(list)
      expect(violations.map(&:message))
        .not_to include(match(/must declare a non-empty symbol/))
    end
  end
end
