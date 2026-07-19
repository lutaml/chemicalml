# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Chemicalml::Cml::ReferenceResolver do
  let(:atom_class) { Chemicalml::Cml::Schema3::Atom }
  let(:bond_class) { Chemicalml::Cml::Schema3::Bond }
  let(:mol_class)  { Chemicalml::Cml::Schema3::Molecule }
  let(:doc_class)  { Chemicalml::Cml::Schema3::Document }

  let(:atoms) do
    [
      atom_class.new(id: 'a1', element_type: 'C'),
      atom_class.new(id: 'a2', element_type: 'O'),
      atom_class.new(id: 'a3', element_type: 'N')
    ]
  end

  let(:bonds) do
    [
      bond_class.new(id: 'b1', atom_refs2: 'a1 a2', order: '1'),
      bond_class.new(id: 'b2', atom_refs2: 'a2 a3', order: '2')
    ]
  end

  let(:molecule) do
    mol_class.new(
      id: 'm1',
      atom_array: Chemicalml::Cml::Schema3::AtomArray.new(atoms: atoms),
      bond_array: Chemicalml::Cml::Schema3::BondArray.new(bonds: bonds)
    )
  end

  let(:document) { doc_class.new(molecules: [molecule]) }
  let(:resolver) { described_class.new(document) }

  describe '#find_atom' do
    it 'returns the atom with the given id' do
      expect(resolver.find_atom(molecule, 'a2')).to be atoms[1]
    end

    it 'returns nil for a missing id' do
      expect(resolver.find_atom(molecule, 'zzz')).to be_nil
    end
  end

  describe '#find_bond' do
    it 'returns the bond with the given id' do
      expect(resolver.find_bond(molecule, 'b2')).to be bonds[1]
    end
  end

  describe '#resolve_atom_refs2' do
    it 'returns a pair of atoms for a valid bond' do
      bond = bonds.first
      resolved = resolver.resolve_atom_refs2(bond, molecule)
      expect(resolved).to eq([atoms[0], atoms[1]])
    end

    it 'returns nils when ids are missing' do
      bond = bond_class.new(id: 'bx', atom_refs2: 'a1 missing1')
      resolved = resolver.resolve_atom_refs2(bond, molecule)
      expect(resolved[0]).to eq(atoms[0])
      expect(resolved[1]).to be_nil
    end

    it 'returns [] for a bond without atom_refs2' do
      bond = bond_class.new(id: 'bx')
      expect(resolver.resolve_atom_refs2(bond, molecule)).to eq([])
    end
  end

  describe '#unresolved_refs' do
    it 'returns empty list when all references resolve' do
      expect(resolver.unresolved_refs).to eq([])
    end

    it 'reports bonds referencing missing atoms' do
      bad_bond = bond_class.new(id: 'bx', atom_refs2: 'a1 missing1')
      molecule.bond_array.bonds << bad_bond
      unresolved = resolver.unresolved_refs
      expect(unresolved.size).to eq(1)
      expect(unresolved[0][:node]).to be bad_bond
      expect(unresolved[0][:attr]).to eq(:atom_refs2)
      expect(unresolved[0][:missing]).to eq(['missing1'])
    end
  end
end
