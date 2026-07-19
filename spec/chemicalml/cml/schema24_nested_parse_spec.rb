# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Schema24 nested XML parse' do
  before do
    Chemicalml::Cml::Schema24::Configuration.ensure_registered!
  end

  it 'parses <cml><molecule/></cml> on Schema24' do
    xml = <<~XML
      <?xml version="1.0"?>
      <cml xmlns="http://www.xml-cml.org/schema">
        <molecule id="m1">
          <atomArray>
            <atom id="a1" elementType="C"/>
          </atomArray>
        </molecule>
      </cml>
    XML
    doc = Chemicalml.parse(xml, schema: :schema24)
    expect(doc).to be_a(Chemicalml::Cml::Schema24::Document)
    expect(doc.molecules.first.id).to eq('m1')
    expect(doc.molecules.first.atom_array.atoms.first.id).to eq('a1')
  end

  it 'parses a standalone <molecule> on Schema24' do
    xml = <<~XML
      <?xml version="1.0"?>
      <molecule xmlns="http://www.xml-cml.org/schema" id="m1"/>
    XML
    mol = Chemicalml.parse(xml, schema: :schema24)
    expect(mol.id).to eq('m1')
  end

  it 'parses molecule with parallel-array atomArray on Schema24' do
    xml = <<~XML
      <?xml version="1.0"?>
      <cml xmlns="http://www.xml-cml.org/schema">
        <molecule id="m1">
          <atomArray atomID="a1 a2 a3" elementType="C O N" x3="0.0 1.0 2.0" y3="0.0 0.0 0.0" z3="0.0 0.0 0.0"/>
        </molecule>
      </cml>
    XML
    doc = Chemicalml.parse(xml, schema: :schema24)
    mol = doc.molecules.first
    expect(mol.id).to eq('m1')
    expect(mol.atom_array.atom_id_array).to eq('a1 a2 a3')
    expect(mol.atom_array.element_type_array).to eq('C O N')
  end
end
