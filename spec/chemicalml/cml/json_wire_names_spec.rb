# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'JSON key_value wire-name preservation (TODO 75)' do
  before do
    Chemicalml::Cml::Schema3::Configuration.ensure_registered!
    Chemicalml::Cml::Schema24::Configuration.ensure_registered!
  end

  it 'Atom JSON uses CML wire names' do
    atom = Chemicalml::Cml::Schema3::Atom.new(
      id: 'a1', element_type: 'C', x3: '1.0', y3: '2.0', z3: '3.0'
    )
    json = atom.to_json
    expect(json).to include('"id":"a1"')
    expect(json).to include('"elementType":"C"')
    expect(json).to include('"x3":"1.0"')
    expect(json).not_to include('"element_type"')
  end

  it 'Molecule JSON uses CML wire names including nested atomArray' do
    mol = Chemicalml::Cml::Schema3::Molecule.new(
      id: 'm1',
      formal_charge: '0',
      atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
        atoms: [Chemicalml::Cml::Schema3::Atom.new(id: 'a1', element_type: 'C')]
      )
    )
    json = mol.to_json
    expect(json).to include('"id":"m1"')
    expect(json).to include('"formalCharge":"0"')
    expect(json).to include('"atomArray":{')
    expect(json).to include('"atom":[')
    expect(json).not_to include('"atom_array"')
    expect(json).not_to include('"formal_charge"')
  end

  it 'AtomArray JSON preserves parallel-array wire names' do
    aa = Chemicalml::Cml::Schema3::AtomArray.new(
      atom_id_array: 'a1 a2',
      element_type_array: 'C O'
    )
    json = aa.to_json
    expect(json).to include('"atomID":"a1 a2"')
    expect(json).to include('"elementType":"C O"')
  end

  it 'Bond JSON uses wire names (atomRefs2, order)' do
    bond = Chemicalml::Cml::Schema3::Bond.new(
      id: 'b1', atom_refs2: 'a1 a2', order: '1'
    )
    json = bond.to_json
    expect(json).to include('"atomRefs2":"a1 a2"')
    expect(json).to include('"order":"1"')
  end

  it 'JSON round-trip preserves wire names' do
    mol = Chemicalml::Cml::Schema3::Molecule.new(
      id: 'm1',
      atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
        atoms: [Chemicalml::Cml::Schema3::Atom.new(id: 'a1', element_type: 'C')]
      )
    )
    json = mol.to_json
    parsed = Chemicalml::Cml::Schema3::Molecule.from_json(json)
    expect(parsed.id).to eq('m1')
    expect(parsed.atom_array.atoms.first.id).to eq('a1')
    expect(parsed.atom_array.atoms.first.element_type).to eq('C')
  end

  it 'YAML also carries wire names' do
    atom = Chemicalml::Cml::Schema3::Atom.new(
      id: 'a1', element_type: 'C', x3: '1.0'
    )
    yaml = atom.to_yaml
    expect(yaml).to include('elementType:')
    expect(yaml).not_to include('element_type:')
  end
end
