# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Chemicalml::Convention::Detection do
  describe '.convention_of' do
    it 'detects molecular on a Document' do
      doc = Chemicalml::Cml::Schema3::Document.new(convention: 'convention:molecular')
      expect(described_class.convention_of(doc)).to eq('convention:molecular')
    end

    it 'detects compchem on a Module' do
      mod = Chemicalml::Cml::Schema3::Module.new(convention: 'convention:compchem')
      expect(described_class.convention_of(mod)).to eq('convention:compchem')
    end

    it 'detects dictionary on a Dictionary' do
      dict = Chemicalml::Cml::Schema3::Dictionary.new(convention: 'convention:dictionary')
      expect(described_class.convention_of(dict)).to eq('convention:dictionary')
    end

    it 'detects unit-dictionary on a UnitList' do
      ul = Chemicalml::Cml::Schema3::UnitList.new(convention: 'convention:unit-dictionary')
      expect(described_class.convention_of(ul)).to eq('convention:unit-dictionary')
    end

    it 'detects unitType-dictionary on a UnitTypeList' do
      utl = Chemicalml::Cml::Schema3::UnitTypeList.new(convention: 'convention:unitType-dictionary')
      expect(described_class.convention_of(utl)).to eq('convention:unitType-dictionary')
    end

    it 'detects spectroscopy on a Spectrum' do
      s = Chemicalml::Cml::Schema3::Spectrum.new(convention: 'convention:spectroscopy')
      expect(described_class.convention_of(s)).to eq('convention:spectroscopy')
    end

    it 'detects spectroscopy on a SpectrumList' do
      sl = Chemicalml::Cml::Schema3::SpectrumList.new(convention: 'convention:spectroscopy')
      expect(described_class.convention_of(sl)).to eq('convention:spectroscopy')
    end

    it 'detects cascade on a ReactionScheme' do
      rs = Chemicalml::Cml::Schema3::ReactionScheme.new(convention: 'convention:cascade')
      expect(described_class.convention_of(rs)).to eq('convention:cascade')
    end

    it 'detects cascade on a ReactionList' do
      rl = Chemicalml::Cml::Schema3::ReactionList.new(convention: 'convention:cascade')
      expect(described_class.convention_of(rl)).to eq('convention:cascade')
    end

    it 'detects simpleUnit on a UnitList' do
      ul = Chemicalml::Cml::Schema3::UnitList.new(convention: 'convention:simpleUnit')
      expect(described_class.convention_of(ul)).to eq('convention:simpleUnit')
    end

    it 'returns nil when no convention is declared' do
      doc = Chemicalml::Cml::Schema3::Document.new
      expect(described_class.convention_of(doc)).to be_nil
    end

    it 'returns nil for non-root element types' do
      atom = Chemicalml::Cml::Schema3::Atom.new(id: 'a1', element_type: 'C')
      expect(described_class.convention_of(atom)).to be_nil
    end
  end
end
