# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'JSON / YAML round-trip (format-agnostic lutaml-model)' do
  let(:atom) do
    Chemicalml::Cml::Schema3::Atom.new(
      id: 'a1', element_type: 'C', x3: '1.0', y3: '2.0', z3: '3.0'
    )
  end

  let(:molecule) do
    Chemicalml::Cml::Schema3::Molecule.new(
      id: 'm1',
      atom_array: Chemicalml::Cml::Schema3::AtomArray.new(atoms: [atom])
    )
  end

  describe 'JSON round-trip' do
    it 'round-trips a molecule through to_json / from_json' do
      json = molecule.to_json
      parsed = Chemicalml::Cml::Schema3::Molecule.from_json(json)
      expect(parsed.id).to eq('m1')
      expect(parsed.atom_array.atoms.first.id).to eq('a1')
      expect(parsed.atom_array.atoms.first.element_type).to eq('C')
      expect(parsed.atom_array.atoms.first.x3).to eq('1.0')
    end

    it 'preserves the data through nested atomArray (JSON uses CML wire names)' do
      json = molecule.to_json
      expect(json).to include('"id":"m1"')
      expect(json).to include('"elementType":"C"')
    end
  end

  describe 'YAML round-trip' do
    it 'round-trips a molecule through to_yaml / from_yaml' do
      yaml = molecule.to_yaml
      parsed = Chemicalml::Cml::Schema3::Molecule.from_yaml(yaml)
      expect(parsed.id).to eq('m1')
      expect(parsed.atom_array.atoms.first.id).to eq('a1')
      expect(parsed.atom_array.atoms.first.element_type).to eq('C')
    end
  end

  describe 'cross-format equivalence' do
    it 'XML and JSON carry the same atom data (wire names)' do
      xml = molecule.to_xml
      json = molecule.to_json
      expect(xml).to include('id="m1"')
      expect(json).to include('"id":"m1"')
      expect(xml).to include('elementType="C"')
      expect(json).to include('"elementType":"C"')
    end
  end
end
