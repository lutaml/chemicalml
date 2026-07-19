# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Performance baseline (TODO 138)' do
  before do
    Chemicalml::Cml::Schema3::Configuration.ensure_registered!
    Chemicalml::Cml::Schema24::Configuration.ensure_registered!
  end

  # Build a large molecule: 1000 atoms, 1500 bonds, plus 100 properties.
  let(:large_molecule) do
    atoms = (1..1000).map do |i|
      Chemicalml::Cml::Schema3::Atom.new(
        id: "a#{i}",
        element_type: i.even? ? 'C' : 'H',
        x3: i.to_f, y3: i.to_f, z3: i.to_f
      )
    end
    bonds = (1..1500).map do |i|
      Chemicalml::Cml::Schema3::Bond.new(
        id: "b#{i}",
        atom_refs2: "a#{(i % 999) + 1} a#{((i + 1) % 999) + 1}",
        order: 'S'
      )
    end
    properties = (1..100).map do |i|
      Chemicalml::Cml::Schema3::Property.new(
        dict_ref: 'cml:bp',
        scalar: Chemicalml::Cml::Schema3::Scalar.new(data_type: 'xsd:float', content: i.to_f.to_s)
      )
    end
    Chemicalml::Cml::Schema3::Document.new(
      convention: 'convention:molecular',
      molecules: [
        Chemicalml::Cml::Schema3::Molecule.new(
          id: 'large',
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(atoms: atoms),
          bond_array: Chemicalml::Cml::Schema3::BondArray.new(bonds: bonds),
          properties: properties
        )
      ]
    )
  end

  def monotonic_ms
    start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    yield
    ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - start) * 1000).round(2)
  end

  describe 'serialisation' do
    it 'serialises the 1000-atom molecule to XML in under 2s' do
      ms = monotonic_ms { large_molecule.to_xml }
      expect(ms).to be < 2000
    end

    it 'serialises to JSON in under 2s' do
      ms = monotonic_ms { large_molecule.to_json }
      expect(ms).to be < 2000
    end
  end

  describe 'validation' do
    it 'validates against the molecular convention in under 2s' do
      ms = monotonic_ms do
        Chemicalml::Convention::Molecular.validate(large_molecule)
      end
      expect(ms).to be < 2000
    end
  end

  describe 'query API' do
    it 'counts atoms recursively in under 500ms' do
      ms = monotonic_ms { large_molecule.atom_count }
      expect(ms).to be < 500
      expect(large_molecule.atom_count).to eq(1000)
    end

    it 'finds an atom by id in under 500ms' do
      ms = monotonic_ms { large_molecule.find_atom('a500') }
      expect(ms).to be < 500
      expect(large_molecule.find_atom('a500')).not_to be_nil
    end
  end

  describe 'fixture parse baseline' do
    it 'parses water.cml in under 20ms' do
      xml = File.read('spec/fixtures/schema3/molecular/water.cml')
      ms = monotonic_ms { Chemicalml.parse(xml, schema: :schema3) }
      expect(ms).to be < 20
    end

    it 'parses methanol.cml in under 20ms' do
      xml = File.read('spec/fixtures/schema3/molecular/methanol.cml')
      ms = monotonic_ms { Chemicalml.parse(xml, schema: :schema3) }
      expect(ms).to be < 20
    end
  end
end
