# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Cross-format interoperability (TODO 96)' do
  before do
    Chemicalml::Cml::Schema3::Configuration.ensure_registered!
  end

  let(:molecule) do
    Chemicalml::Cml::Schema3::Molecule.new(
      id: 'm1',
      formal_charge: '0',
      atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
        atoms: [
          Chemicalml::Cml::Schema3::Atom.new(id: 'a1', element_type: 'C', x3: '1.0', y3: '2.0', z3: '3.0'),
          Chemicalml::Cml::Schema3::Atom.new(id: 'a2', element_type: 'O', x3: '2.0', y3: '3.0', z3: '4.0')
        ]
      ),
      bond_array: Chemicalml::Cml::Schema3::BondArray.new(
        bonds: [
          Chemicalml::Cml::Schema3::Bond.new(id: 'b1', atom_refs2: 'a1 a2', order: 'S')
        ]
      )
    )
  end

  def fingerprint(node, counts = Hash.new(0))
    return counts unless node.is_a?(Lutaml::Model::Serializable)

    name = node.class.name.split('::').last
    counts[name] += 1
    if node.is_a?(Chemicalml::Cml::Visitable)
      node.wire_children.each { |c| fingerprint(c, counts) }
    end
    counts
  end

  describe 'XML → JSON → XML' do
    it 'preserves the structural fingerprint through XML → JSON → XML' do
      xml1 = molecule.to_xml
      mol_via_json = Chemicalml::Cml::Schema3::Molecule.from_json(molecule.to_json)
      xml2 = mol_via_json.to_xml
      mol2 = Chemicalml::Cml::Schema3::Molecule.from_xml(xml2)
      expect(fingerprint(mol2)).to eq(fingerprint(molecule))
    end
  end

  describe 'XML → YAML → XML' do
    it 'preserves the structural fingerprint through XML → YAML → XML' do
      mol_via_yaml = Chemicalml::Cml::Schema3::Molecule.from_yaml(molecule.to_yaml)
      xml2 = mol_via_yaml.to_xml
      mol2 = Chemicalml::Cml::Schema3::Molecule.from_xml(xml2)
      expect(fingerprint(mol2)).to eq(fingerprint(molecule))
    end
  end

  describe 'JSON → JSON idempotency' do
    it 'preserves the JSON output across two serialise-parse cycles' do
      json1 = molecule.to_json
      mol2 = Chemicalml::Cml::Schema3::Molecule.from_json(json1)
      json2 = mol2.to_json
      expect(json2).to eq(json1)
    end
  end

  describe 'XML → JSON → YAML equivalence' do
    it 'produces equivalent data through XML → JSON → YAML → XML' do
      xml1 = molecule.to_xml
      json = molecule.to_json
      mol_from_json = Chemicalml::Cml::Schema3::Molecule.from_json(json)
      yaml = mol_from_json.to_yaml
      mol_from_yaml = Chemicalml::Cml::Schema3::Molecule.from_yaml(yaml)
      xml2 = mol_from_yaml.to_xml
      mol2 = Chemicalml::Cml::Schema3::Molecule.from_xml(xml2)
      expect(fingerprint(mol2)).to eq(fingerprint(molecule))
    end
  end
end
