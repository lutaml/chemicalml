# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'TOML round-trip' do
  before do
    begin
      require 'tomlib'
    rescue LoadError
      skip 'tomlib not installed — TOML adapter required'
    end
  end

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

  it 'Atom serialises to TOML' do
    toml = atom.to_toml
    expect(toml).to be_a(String)
    expect(toml).to include('id = "a1"')
    expect(toml).to include('elementType = "C"')
  end

  it 'Atom round-trips through to_toml / from_toml' do
    parsed = Chemicalml::Cml::Schema3::Atom.from_toml(atom.to_toml)
    expect(parsed.id).to eq('a1')
    expect(parsed.element_type).to eq('C')
    expect(parsed.x3).to eq('1.0')
  end

  it 'Molecule carries nested atomArray in TOML' do
    toml = molecule.to_toml
    expect(toml).to include('id = "m1"')
    expect(toml).to include('elementType = "C"')
  end
end
