# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Chemicalml::Convention::Registry do
  before do
    Chemicalml::Cml::Schema3::Configuration.ensure_registered!
  end

  describe '.each' do
    it 'iterates every registered convention' do
      conventions = described_class.each.to_a
      expect(conventions.size).to eq(8)
      expect(conventions.map(&:qname)).to include('convention:molecular')
    end

    it 'yields conventions sorted by QName' do
      qnames = described_class.each.map(&:qname)
      expect(qnames).to eq(qnames.sort)
    end

    it 'yields modules that have constraint_count' do
      described_class.each do |conv|
        expect(conv.constraint_count).to be >= 1
      end
    end
  end

  describe '.convention_root?' do
    it 'returns true for known convention-bearing roles' do
      expect(described_class.convention_root?(Chemicalml::Cml::Role::Document)).to be true
      expect(described_class.convention_root?(Chemicalml::Cml::Role::Module)).to be true
      expect(described_class.convention_root?(Chemicalml::Cml::Role::Molecule)).to be true
      expect(described_class.convention_root?(Chemicalml::Cml::Role::Dictionary)).to be true
      expect(described_class.convention_root?(Chemicalml::Cml::Role::UnitList)).to be true
      expect(described_class.convention_root?(Chemicalml::Cml::Role::UnitTypeList)).to be true
      expect(described_class.convention_root?(Chemicalml::Cml::Role::Spectrum)).to be true
      expect(described_class.convention_root?(Chemicalml::Cml::Role::SpectrumList)).to be true
      expect(described_class.convention_root?(Chemicalml::Cml::Role::ReactionScheme)).to be true
      expect(described_class.convention_root?(Chemicalml::Cml::Role::ReactionList)).to be true
    end

    it 'returns false for non-root roles' do
      expect(described_class.convention_root?(Chemicalml::Cml::Role::Atom)).to be false
      expect(described_class.convention_root?(Chemicalml::Cml::Role::Bond)).to be false
      expect(described_class.convention_root?(Chemicalml::Cml::Role::Peak)).to be false
    end
  end
end
