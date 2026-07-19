# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'enum validation constraints (TODO 81)' do
  let(:atom_class)    { Chemicalml::Cml::Schema3::Atom }
  let(:bond_class)    { Chemicalml::Cml::Schema3::Bond }
  let(:stereo_class)  { Chemicalml::Cml::Schema3::BondStereo }
  let(:mol_class)     { Chemicalml::Cml::Schema3::Molecule }
  let(:doc_class)     { Chemicalml::Cml::Schema3::Document }

  def doc_with(bond_order: nil, stereo_value: nil, chirality: nil)
    bond = bond_class.new(id: 'b1', atom_refs2: 'a1 a2', order: bond_order)
    bond.bond_stereo = stereo_class.new(content: stereo_value) if stereo_value
    mol = mol_class.new(
      id: 'm1',
      chirality: chirality,
      atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
        atoms: [
          atom_class.new(id: 'a1', element_type: 'C'),
          atom_class.new(id: 'a2', element_type: 'O')
        ]
      ),
      bond_array: Chemicalml::Cml::Schema3::BondArray.new(bonds: [bond])
    )
    doc_class.new(molecules: [mol])
  end

  def validate(doc)
    Chemicalml::Convention::Molecular.validate(doc)
  end

  describe 'BondOrderShouldBeInEnum' do
    it 'passes when order is in the enum' do
      v = validate(doc_with(bond_order: 'S'))
      expect(v.map(&:message)).not_to include(match(/order .+ should be one of/))
    end

    it 'warns when order is outside the enum' do
      v = validate(doc_with(bond_order: 'X9'))
      order_v = v.find { |x| x.message.match?(/order .+ should be one of/) }
      expect(order_v).not_to be_nil
      expect(order_v.severity).to eq(:warning)
      expect(order_v.value).to eq('X9')
    end

    it 'passes when order is empty (other constraints handle that)' do
      v = validate(doc_with(bond_order: nil))
      expect(v.map(&:message)).not_to include(match(/order .+ should be one of/))
    end
  end

  describe 'BondStereoShouldBeInEnum' do
    it 'passes when stereo value is in the enum' do
      v = validate(doc_with(stereo_value: 'C'))
      expect(v.map(&:message)).not_to include(match(/bondStereo .+ should be one of/))
    end

    it 'warns when stereo value is outside the enum' do
      v = validate(doc_with(stereo_value: 'XYZ'))
      stereo_v = v.find { |x| x.message.match?(/bondStereo .+ should be one of/) }
      expect(stereo_v).not_to be_nil
      expect(stereo_v.value).to eq('XYZ')
    end
  end

  describe 'MoleculeChiralityShouldBeInEnum' do
    it 'passes when chirality is in the enum' do
      v = validate(doc_with(chirality: 'racemate'))
      expect(v.map(&:message)).not_to include(match(/chirality .+ should be one of/))
    end

    it 'warns when chirality is outside the enum' do
      v = validate(doc_with(chirality: 'mirror'))
      chiral_v = v.find { |x| x.message.match?(/chirality .+ should be one of/) }
      expect(chiral_v).not_to be_nil
      expect(chiral_v.value).to eq('mirror')
    end
  end
end
