# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Round 26 constraints' do
  let(:atom_class)    { Chemicalml::Cml::Schema3::Atom }
  let(:bond_class)    { Chemicalml::Cml::Schema3::Bond }
  let(:parity_class)  { Chemicalml::Cml::Schema3::AtomParity }
  let(:mol_class)     { Chemicalml::Cml::Schema3::Molecule }
  let(:doc_class)     { Chemicalml::Cml::Schema3::Document }

  def validate(doc)
    Chemicalml::Convention::Molecular.validate(doc)
  end

  describe 'XSD pattern constants' do
    it 'Cml::Patterns has all XSD patterns' do
      expect(Chemicalml::Cml::Patterns.constants(false).size).to be >= 14
    end

    it 'ID_PATTERN matches valid ids' do
      expect('atom1').to match(Chemicalml::Cml::Patterns::ID_PATTERN)
      expect('atom.1').to match(Chemicalml::Cml::Patterns::ID_PATTERN)
      expect('atom-1').to match(Chemicalml::Cml::Patterns::ID_PATTERN)
    end

    it 'ID_PATTERN rejects invalid ids (when anchored)' do
      anchored = /\A#{Chemicalml::Cml::Patterns::ID_PATTERN.source}\z/
      expect('atom').to match(anchored)
      expect('atom space'.match?(anchored)).to be false
      expect('1atom'.match?(anchored)).to be false
    end

    it 'NAMESPACE_PATTERN matches HTTP URIs ending with /' do
      expect('http://www.xml-cml.org/convention/molecular').to match(Chemicalml::Cml::Patterns::NAMESPACE_PATTERN)
      expect('http://www.xml-cml.org/convention/').to match(Chemicalml::Cml::Patterns::NAMESPACE_PATTERN)
    end
  end

  describe 'MoleculeIdShouldMatchPattern' do
    it 'warns on a malformed molecule id' do
      doc = doc_class.new(
        molecules: [mol_class.new(id: '1bad', atom_array: Chemicalml::Cml::Schema3::AtomArray.new)]
      )
      v = validate(doc)
      mid_v = v.find { |x| x.message.match?(/molecule id .+ should match/) }
      expect(mid_v).not_to be_nil
      expect(mid_v.value).to eq('1bad')
    end

    it 'passes on a valid molecule id' do
      doc = doc_class.new(
        molecules: [mol_class.new(id: 'm1', atom_array: Chemicalml::Cml::Schema3::AtomArray.new)]
      )
      v = validate(doc)
      expect(v.map(&:message)).not_to include(match(/molecule id .+ should match/))
    end
  end

  describe 'BondIdShouldMatchPattern' do
    it 'warns on a malformed bond id' do
      doc = doc_class.new(
        molecules: [mol_class.new(
          id: 'm1',
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
            atoms: [atom_class.new(id: 'a1', element_type: 'C'),
                    atom_class.new(id: 'a2', element_type: 'O')]
          ),
          bond_array: Chemicalml::Cml::Schema3::BondArray.new(
            bonds: [bond_class.new(id: '1bad', atom_refs2: 'a1 a2', order: 'S')]
          )
        )]
      )
      v = validate(doc)
      bid_v = v.find { |x| x.message.match?(/bond id .+ should match/) }
      expect(bid_v).not_to be_nil
      expect(bid_v.value).to eq('1bad')
    end
  end

  describe 'AtomParityShouldIncludeParentAtom' do
    it 'warns when parent atom id is not in atomRefs4' do
      atom = atom_class.new(id: 'a1', element_type: 'C')
      atom.atom_parity = parity_class.new(atom_refs4: 'a2 a3 a4 a5')
      doc = doc_class.new(
        molecules: [mol_class.new(
          id: 'm1',
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
            atoms: [
              atom,
              atom_class.new(id: 'a2', element_type: 'H'),
              atom_class.new(id: 'a3', element_type: 'H'),
              atom_class.new(id: 'a4', element_type: 'H'),
              atom_class.new(id: 'a5', element_type: 'Cl')
            ]
          )
        )]
      )
      v = validate(doc)
      parity_v = v.find { |x| x.message.match?(/should include the parent atom id/) }
      expect(parity_v).not_to be_nil
      expect(parity_v.severity).to eq(:warning)
    end

    it 'passes when parent atom id is in atomRefs4' do
      atom = atom_class.new(id: 'a1', element_type: 'C')
      atom.atom_parity = parity_class.new(atom_refs4: 'a1 a2 a3 a4')
      doc = doc_class.new(
        molecules: [mol_class.new(
          id: 'm1',
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
            atoms: [
              atom,
              atom_class.new(id: 'a2', element_type: 'H'),
              atom_class.new(id: 'a3', element_type: 'H'),
              atom_class.new(id: 'a4', element_type: 'H')
            ]
          )
        )]
      )
      v = validate(doc)
      expect(v.map(&:message)).not_to include(match(/should include the parent atom id/))
    end
  end
end
