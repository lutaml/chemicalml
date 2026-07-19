# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'distinct atoms + unresolved refs (TODO 85, 86)' do
  let(:atom_class) { Chemicalml::Cml::Schema3::Atom }
  let(:bond_class) { Chemicalml::Cml::Schema3::Bond }
  let(:mol_class)  { Chemicalml::Cml::Schema3::Molecule }
  let(:doc_class)  { Chemicalml::Cml::Schema3::Document }

  def doc_with_bonds(bonds)
    doc_class.new(
      molecules: [
        mol_class.new(
          id: 'm1',
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
            atoms: [
              atom_class.new(id: 'a1', element_type: 'C'),
              atom_class.new(id: 'a2', element_type: 'O')
            ]
          ),
          bond_array: Chemicalml::Cml::Schema3::BondArray.new(bonds: bonds)
        )
      ]
    )
  end

  def validate(doc)
    Chemicalml::Convention::Molecular.validate(doc)
  end

  describe 'BondAtomRefs2ShouldBeDistinct' do
    it 'warns when atomRefs2 references the same atom twice' do
      doc = doc_with_bonds([bond_class.new(id: 'b1', atom_refs2: 'a1 a1', order: 'S')])
      v = validate(doc)
      distinct_v = v.find { |x| x.message.match?(/two distinct atoms/) }
      expect(distinct_v).not_to be_nil
      expect(distinct_v.severity).to eq(:warning)
      expect(distinct_v.value).to eq('a1 a1')
    end

    it 'passes when atomRefs2 references two different atoms' do
      doc = doc_with_bonds([bond_class.new(id: 'b1', atom_refs2: 'a1 a2', order: 'S')])
      v = validate(doc)
      expect(v.map(&:message)).not_to include(match(/two distinct atoms/))
    end
  end

  describe 'ReferencesShouldResolve' do
    it 'warns when atomRefs2 references a missing atom' do
      doc = doc_with_bonds([bond_class.new(id: 'b1', atom_refs2: 'a1 a99', order: 'S')])
      v = validate(doc)
      unresolved_v = v.find { |x| x.message.match?(/missing atoms/) }
      expect(unresolved_v).not_to be_nil
      expect(unresolved_v.value).to eq(['a99'])
    end

    it 'passes when atomRefs2 references existing atoms' do
      doc = doc_with_bonds([bond_class.new(id: 'b1', atom_refs2: 'a1 a2', order: 'S')])
      v = validate(doc)
      expect(v.map(&:message)).not_to include(match(/missing atoms/))
    end
  end
end
