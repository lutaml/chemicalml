# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Chemicalml::Cml::CanonicalComparison do
  let(:mol_class) { Chemicalml::Cml::Schema3::Molecule }
  let(:atom_class) { Chemicalml::Cml::Schema3::Atom }
  let(:bond_class) { Chemicalml::Cml::Schema3::Bond }

  let(:left) do
    mol_class.new(
      id: 'm1',
      atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
        atoms: [
          atom_class.new(id: 'a1', element_type: 'C'),
          atom_class.new(id: 'a2', element_type: 'O')
        ]
      ),
      bond_array: Chemicalml::Cml::Schema3::BondArray.new(
        bonds: [bond_class.new(id: 'b1', atom_refs2: 'a1 a2', order: 'S')]
      )
    )
  end

  describe '#equal?' do
    it 'returns true for canonically equal documents' do
      right = mol_class.new(
        id: 'm1',
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
          atoms: [
            atom_class.new(id: 'a1', element_type: 'C'),
            atom_class.new(id: 'a2', element_type: 'O')
          ]
        ),
        bond_array: Chemicalml::Cml::Schema3::BondArray.new(
          bonds: [bond_class.new(id: 'b1', atom_refs2: 'a1 a2', order: 'S')]
        )
      )
      expect(described_class.new(left, right).equal?).to be true
    end

    it 'returns false when atom count differs' do
      right = mol_class.new(
        id: 'm1',
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
          atoms: [atom_class.new(id: 'a1', element_type: 'C')]
        )
      )
      expect(described_class.new(left, right).equal?).to be false
    end

    it 'returns false when bond count differs' do
      right = mol_class.new(
        id: 'm1',
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
          atoms: [
            atom_class.new(id: 'a1', element_type: 'C'),
            atom_class.new(id: 'a2', element_type: 'O')
          ]
        ),
        bond_array: Chemicalml::Cml::Schema3::BondArray.new(bonds: [])
      )
      expect(described_class.new(left, right).equal?).to be false
    end
  end

  describe '#diff' do
    it 'returns empty hash for equal documents' do
      right = left
      expect(described_class.new(left, right).diff).to eq({})
    end

    it 'shows Atom count delta' do
      right = mol_class.new(
        id: 'm1',
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
          atoms: [atom_class.new(id: 'a1', element_type: 'C')]
        )
      )
      diff = described_class.new(left, right).diff
      expect(diff['Atom']).to eq(-1)
    end

    it 'shows Bond count delta' do
      right = mol_class.new(
        id: 'm1',
        atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
          atoms: [
            atom_class.new(id: 'a1', element_type: 'C'),
            atom_class.new(id: 'a2', element_type: 'O')
          ]
        ),
        bond_array: Chemicalml::Cml::Schema3::BondArray.new(
          bonds: [
            bond_class.new(id: 'b1', atom_refs2: 'a1 a2', order: 'S'),
            bond_class.new(id: 'b2', atom_refs2: 'a1 a2', order: 'S')
          ]
        )
      )
      diff = described_class.new(left, right).diff
      expect(diff['Bond']).to eq(1)
    end
  end
end
