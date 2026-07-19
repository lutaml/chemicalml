# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Round 27 user-facing API' do
  let(:atom_class) { Chemicalml::Cml::Schema3::Atom }
  let(:bond_class) { Chemicalml::Cml::Schema3::Bond }
  let(:mol_class)  { Chemicalml::Cml::Schema3::Molecule }
  let(:doc_class)  { Chemicalml::Cml::Schema3::Document }

  let(:document) do
    inner = mol_class.new(
      id: 'inner',
      atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
        atoms: [atom_class.new(id: 'a3', element_type: 'N')]
      )
    )
    outer = mol_class.new(
      id: 'outer',
      atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
        atoms: [
          atom_class.new(id: 'a1', element_type: 'C'),
          atom_class.new(id: 'a2', element_type: 'O')
        ]
      ),
      bond_array: Chemicalml::Cml::Schema3::BondArray.new(
        bonds: [bond_class.new(id: 'b1', atom_refs2: 'a1 a2', order: 'S')]
      ),
      molecules: [inner]
    )
    doc_class.new(molecules: [outer])
  end

  describe Chemicalml::Cml::Visitable do
    describe '#each_atom' do
      it 'iterates every atom in the subtree recursively' do
        ids = document.each_atom.map(&:id)
        expect(ids).to contain_exactly('a1', 'a2', 'a3')
      end

      it 'returns an Enumerator without a block' do
        expect(document.each_atom).to be_an(Enumerator)
      end
    end

    describe '#each_bond' do
      it 'iterates every bond' do
        expect(document.each_bond.map(&:id)).to eq(['b1'])
      end
    end

    describe '#each_molecule' do
      it 'iterates every molecule recursively' do
        expect(document.each_molecule.map(&:id)).to eq(%w[outer inner])
      end
    end

    describe '#find_atom' do
      it 'finds an atom by id' do
        expect(document.find_atom('a2').element_type).to eq('O')
      end

      it 'finds atoms in nested molecules' do
        expect(document.find_atom('a3').element_type).to eq('N')
      end

      it 'returns nil for missing ids' do
        expect(document.find_atom('nonexistent')).to be_nil
      end
    end

    describe '#find_bond' do
      it 'finds a bond by id' do
        expect(document.find_bond('b1').order).to eq('S')
      end
    end

    describe '#find_molecule' do
      it 'finds a molecule by id' do
        expect(document.find_molecule('inner')).to be_a(mol_class)
      end
    end

    describe '#atom_count / #bond_count / #molecule_count' do
      it 'returns recursive counts' do
        expect(document.atom_count).to eq(3)
        expect(document.bond_count).to eq(1)
        expect(document.molecule_count).to eq(2)
      end
    end

    describe '#each_wire_node' do
      it 'iterates every wire node recursively' do
        all_nodes = document.each_wire_node.to_a
        expect(all_nodes.size).to be > 5
        expect(all_nodes).to all(be_a(Lutaml::Model::Serializable))
      end
    end
  end

  describe 'Chemicalml.validate' do
    it 'auto-detects and validates the convention' do
      doc = doc_class.new(
        convention: 'convention:molecular',
        molecules: [mol_class.new(
          id: 'm1',
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
            atoms: [atom_class.new(id: 'a1', element_type: 'C')]
          )
        )]
      )
      report = Chemicalml.validate(doc)
      expect(report).to be_a(Chemicalml::Convention::ValidationReport)
    end

    it 'raises ArgumentError when no convention is declared' do
      expect { Chemicalml.validate(doc_class.new) }.to raise_error(ArgumentError)
    end
  end

  describe 'CLI inspect command' do
    it 'prints a tree-style summary' do
      out = capture_stdout do
        Chemicalml::Cli.run(%w[inspect spec/fixtures/schema3/molecular/water.cml])
      end
      expect(out).to include('Document')
      expect(out).to include('Molecule')
      expect(out).to include('AtomArray')
    end

    it 'returns 0 on success' do
      expect(Chemicalml::Cli.run(%w[inspect spec/fixtures/schema3/molecular/water.cml])).to eq(0)
    end
  end

  describe 'CLI elements command' do
    it 'lists every Schema3 wire class' do
      out = capture_stdout { Chemicalml::Cli.run(%w[elements]) }
      expect(out).to include('Atom')
      expect(out).to include('Molecule')
      expect(out).to include('Bond')
      expect(out).to include('Spectrum')
    end
  end

  def capture_stdout
    original = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = original
  end
end
