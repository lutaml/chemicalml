# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Chemicalml::Convention::Violation do
  describe 'value field (TODO 71)' do
    it 'accepts and exposes a value' do
      v = described_class.new(path: 'atom[a1]', message: 'bad id',
                              value: 'a1!')
      expect(v.value).to eq('a1!')
    end

    it 'defaults value to nil' do
      expect(described_class.new(path: 'x', message: 'y').value).to be_nil
    end

    it 'includes the value in to_s when present' do
      v = described_class.new(path: 'atom[a1]', message: 'bad id', value: 'a1!')
      expect(v.to_s).to include('value="a1!"')
    end

    it 'omits the value suffix from to_s when nil' do
      v = described_class.new(path: 'atom[a1]', message: 'bad id')
      expect(v.to_s).not_to include('value=')
    end

    it 'is frozen along with its value' do
      v = described_class.new(path: 'x', message: 'y',
                              value: { a: 1 }.freeze)
      expect(v).to be_frozen
      expect(v.value).to be_frozen
    end
  end

  describe 'constraints populate value' do
    it 'AtomIdMustMatchPattern populates value with the offending id' do
      atom = Chemicalml::Cml::Schema3::Atom.new(id: '1bad', element_type: 'C')
      mol = Chemicalml::Cml::Schema3::Molecule.new(
        id: 'm1',
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(atoms: [atom])
      )
      doc = Chemicalml::Cml::Schema3::Document.new(molecules: [mol])
      violations = Chemicalml::Convention::Molecular.validate(doc)
      pattern_v = violations.find { |v| v.message.match?(/atom id/) }
      expect(pattern_v.value).to eq('1bad')
    end

    it 'PeakShouldHaveValues populates value with xValue/yValue hash' do
      spectrum = Chemicalml::Cml::Schema3::Spectrum.new(
        id: 's1', format: 'ir', convention: 'convention:spectroscopy',
        peak_list: Chemicalml::Cml::Schema3::PeakList.new(
          peaks: [Chemicalml::Cml::Schema3::Peak.new(id: 'p1')]
        )
      )
      violations = Chemicalml::Convention::Spectroscopy.validate(spectrum)
      peak_v = violations.find { |v| v.message.match?(/should have at least one/) }
      expect(peak_v.value).to eq({ xValue: nil, yValue: nil }.freeze)
    end

    it 'UnitMustHavePower populates value with the missing power' do
      list = Chemicalml::Cml::Schema3::UnitList.new(
        convention: 'convention:simpleUnit',
        units: [Chemicalml::Cml::Schema3::Unit.new(id: 'u1', symbol: 'J')]
      )
      violations = Chemicalml::Convention::SimpleUnit.validate(list)
      power_v = violations.find { |v| v.message.match?(/must declare a power/) }
      expect(power_v.value).to be_nil
    end
  end
end
