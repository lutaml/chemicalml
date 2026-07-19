# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'round 23 constraints (TODO 90-92)' do
  let(:atom_class)    { Chemicalml::Cml::Schema3::Atom }
  let(:bond_class)    { Chemicalml::Cml::Schema3::Bond }
  let(:stereo_class)  { Chemicalml::Cml::Schema3::BondStereo }
  let(:parity_class)  { Chemicalml::Cml::Schema3::AtomParity }
  let(:mol_class)     { Chemicalml::Cml::Schema3::Molecule }
  let(:doc_class)     { Chemicalml::Cml::Schema3::Document }

  def doc_with(stereo: nil, parity: nil)
    bond = bond_class.new(id: 'b1', atom_refs2: 'a1 a2', order: 'S')
    bond.bond_stereo = stereo_class.new(content: stereo[:content],
                                        atom_refs4: stereo[:atom_refs4]) if stereo
    atom1 = atom_class.new(id: 'a1', element_type: 'C')
    atom1.atom_parity = parity_class.new(atom_refs4: parity[:atom_refs4]) if parity && parity[:which] == :a1
    mol = mol_class.new(
      id: 'm1',
      atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
        atoms: [
          atom1,
          atom_class.new(id: 'a2', element_type: 'O'),
          atom_class.new(id: 'a3', element_type: 'N'),
          atom_class.new(id: 'a4', element_type: 'H')
        ]
      ),
      bond_array: Chemicalml::Cml::Schema3::BondArray.new(bonds: [bond])
    )
    doc_class.new(molecules: [mol])
  end

  def validate_molecular(doc)
    Chemicalml::Convention::Molecular.validate(doc)
  end

  describe 'BondStereoAtomRefs4ShouldBeDistinct' do
    it 'warns when atomRefs4 has duplicate atoms' do
      doc = doc_with(stereo: { content: 'C', atom_refs4: 'a1 a2 a3 a3' })
      v = validate_molecular(doc)
      sv = v.find { |x| x.message.match?(/atomRefs4 should reference four distinct/) }
      expect(sv).not_to be_nil
      expect(sv.severity).to eq(:warning)
    end

    it 'passes when atomRefs4 has 4 distinct atoms' do
      doc = doc_with(stereo: { content: 'C', atom_refs4: 'a1 a2 a3 a4' })
      v = validate_molecular(doc)
      expect(v.map(&:message)).not_to include(match(/atomRefs4 should reference four distinct/))
    end
  end

  describe 'AtomParityAtomRefs4ShouldBeDistinct' do
    it 'warns when atomParity atomRefs4 has duplicate atoms' do
      doc = doc_with(parity: { atom_refs4: 'a1 a2 a3 a3', which: :a1 })
      v = validate_molecular(doc)
      sv = v.find { |x| x.message.match?(/atomParity .* atomRefs4 should reference/) }
      expect(sv).not_to be_nil
    end

    it 'passes when atomParity atomRefs4 has 4 distinct atoms' do
      doc = doc_with(parity: { atom_refs4: 'a1 a2 a3 a4', which: :a1 })
      v = validate_molecular(doc)
      expect(v.map(&:message)).not_to include(match(/atomParity .* atomRefs4 should reference/))
    end
  end

  describe 'Unit-dictionary completeness (TODO 92)' do
    let(:unit_class) { Chemicalml::Cml::Schema3::Unit }
    let(:list_class) { Chemicalml::Cml::Schema3::UnitList }

    def list_with(unit_attrs = {})
      list_class.new(
        convention: 'convention:unit-dictionary',
        units: [unit_class.new(unit_attrs)]
      )
    end

    def validate_unit_dict(list)
      Chemicalml::Convention::UnitDictionary.validate(list)
    end

    let(:good_attrs) do
      {
        id: 'm', title: 'metre', symbol: 'm', parent_si: 'si:m',
        multiplier_to_si: '1.0', unit_type: 'unitType:length',
        definition: Chemicalml::Cml::Schema3::Definition.new
      }
    end

    it 'passes a fully specified unit' do
      v = validate_unit_dict(list_with(good_attrs))
      expect(v.map(&:message)).not_to include(match(/must have a title/))
      expect(v.map(&:message)).not_to include(match(/must have a parentSI/))
      expect(v.map(&:message)).not_to include(match(/multiplierToSI or constantToSI/))
    end

    it 'flags a unit without title' do
      attrs = good_attrs.reject { |k, _| k == :title }
      v = validate_unit_dict(list_with(attrs))
      expect(v.map(&:message)).to include(match(/must have a title attribute/))
    end

    it 'flags a unit without parentSI' do
      attrs = good_attrs.reject { |k, _| k == :parent_si }
      v = validate_unit_dict(list_with(attrs))
      expect(v.map(&:message)).to include(match(/must have a parentSI attribute/))
    end

    it 'flags a unit without both multiplierToSI and constantToSI' do
      attrs = good_attrs.reject { |k, _| k == :multiplier_to_si }
      v = validate_unit_dict(list_with(attrs))
      expect(v.map(&:message)).to include(match(/multiplierToSI or constantToSI/))
    end

    it 'accepts constantToSI instead of multiplierToSI' do
      attrs = good_attrs.dup
      attrs.delete(:multiplier_to_si)
      attrs[:constant_to_si] = '0.0'
      v = validate_unit_dict(list_with(attrs))
      expect(v.map(&:message)).not_to include(match(/multiplierToSI or constantToSI/))
    end
  end
end
