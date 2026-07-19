# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Round 31 — parentSI resolution' do
  let(:unit_class) { Chemicalml::Cml::Schema3::Unit }
  let(:list_class) { Chemicalml::Cml::Schema3::UnitList }

  def list_with(parent_si:)
    list_class.new(
      convention: 'convention:unit-dictionary',
      units: [unit_class.new(
        id: 'm', title: 'metre', symbol: 'm',
        parent_si: parent_si, multiplier_to_si: '1.0',
        unit_type: 'unitType:length',
        definition: Chemicalml::Cml::Schema3::Definition.new
      )]
    )
  end

  def validate(list)
    Chemicalml::Convention::UnitDictionary.validate(list)
  end

  describe 'UnitParentSiShouldResolve' do
    it 'warns when parentSI does not resolve' do
      list = list_with(parent_si: 'si:metr')
      v = validate(list)
      ps_v = v.find { |x| x.message.match?(/parentSI .+ does not resolve/) }
      expect(ps_v).not_to be_nil
      expect(ps_v.value).to eq('si:metr')
    end

    it 'passes when parentSI resolves to an SI entry' do
      list = list_with(parent_si: 'si:m')
      v = validate(list)
      ps_v = v.find { |x| x.message.match?(/parentSI .+ does not resolve/) }
      expect(ps_v).to be_nil
    end

    it 'passes when parentSI is empty (other constraint handles that)' do
      list = list_with(parent_si: '')
      v = validate(list)
      ps_v = v.find { |x| x.message.match?(/parentSI .+ does not resolve/) }
      expect(ps_v).to be_nil
    end
  end
end
