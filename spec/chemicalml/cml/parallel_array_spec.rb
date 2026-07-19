# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'parallel-array atomArray/bondArray round-trip' do
  describe 'atomArray parallel-array form' do
    let(:xml) do
      <<~XML
        <?xml version="1.0"?>
        <cml xmlns="http://www.xml-cml.org/schema">
          <molecule id="m1">
            <atomArray atomID="a1 a2 a3"
                       elementType="C O N"
                       x3="0.0 1.2 2.4"
                       y3="0.0 0.0 0.0"
                       z3="0.0 0.0 0.0"
                       formalCharge="0 0 1"
                       hydrogenCount="4 2 3"/>
          </molecule>
        </cml>
      XML
    end

    it 'parses the parallel-array attributes on Schema3' do
      doc = Chemicalml.parse(xml, schema: :schema3)
      aa = doc.molecules.first.atom_array
      expect(aa.atom_id_array).to eq('a1 a2 a3')
      expect(aa.element_type_array).to eq('C O N')
      expect(aa.x3_array).to eq('0.0 1.2 2.4')
      expect(aa.formal_charge_array).to eq('0 0 1')
      expect(aa.hydrogen_count_array).to eq('4 2 3')
    end

    it 'parses the parallel-array attributes on Schema24' do
      Chemicalml::Cml::Schema24::Configuration.ensure_registered!
      aa = Chemicalml::Cml::Schema24::AtomArray.new(
        atom_id_array: 'a1 a2 a3',
        element_type_array: 'C O N',
        x3_array: '0.0 1.2 2.4'
      )
      expect(aa.atom_id_array).to eq('a1 a2 a3')
      expect(aa.element_type_array).to eq('C O N')
      expect(aa.x3_array).to eq('0.0 1.2 2.4')
      xml = aa.to_xml
      expect(xml).to include('atomID="a1 a2 a3"')
      expect(xml).to include('elementType="C O N"')
    end

    it 'round-trips parallel-array attributes through Schema3' do
      doc = Chemicalml.parse(xml, schema: :schema3)
      roundtrip = Chemicalml.serialize(doc)
      expect(roundtrip).to include('atomID="a1 a2 a3"')
      expect(roundtrip).to include('elementType="C O N"')
      expect(roundtrip).to include('x3="0.0 1.2 2.4"')
      expect(roundtrip).to include('formalCharge="0 0 1"')
    end
  end

  describe 'bondArray parallel-array form' do
    let(:xml) do
      <<~XML
        <?xml version="1.0"?>
        <cml xmlns="http://www.xml-cml.org/schema">
          <molecule id="m1">
            <atomArray atomID="a1 a2 a3" elementType="C O N"/>
            <bondArray atomRef1="a1 a2"
                       atomRef2="a2 a3"
                       bondID="b1 b2"
                       order="1 2"/>
          </molecule>
        </cml>
      XML
    end

    it 'parses the parallel-array attributes on Schema3' do
      doc = Chemicalml.parse(xml, schema: :schema3)
      ba = doc.molecules.first.bond_array
      expect(ba.atom_ref1_array).to eq('a1 a2')
      expect(ba.atom_ref2_array).to eq('a2 a3')
      expect(ba.bond_id_array).to eq('b1 b2')
      expect(ba.order_array).to eq('1 2')
    end

    it 'round-trips parallel-array bond attributes through Schema3' do
      doc = Chemicalml.parse(xml, schema: :schema3)
      roundtrip = Chemicalml.serialize(doc)
      expect(roundtrip).to include('atomRef1="a1 a2"')
      expect(roundtrip).to include('atomRef2="a2 a3"')
      expect(roundtrip).to include('order="1 2"')
    end
  end

  describe 'child form is unaffected' do
    let(:xml) do
      <<~XML
        <?xml version="1.0"?>
        <cml xmlns="http://www.xml-cml.org/schema">
          <molecule id="m1">
            <atomArray>
              <atom id="a1" elementType="C" x3="0.0" y3="0.0" z3="0.0"/>
              <atom id="a2" elementType="O" x3="1.2" y3="0.0" z3="0.0"/>
            </atomArray>
          </molecule>
        </cml>
      XML
    end

    it 'still parses children after the rename' do
      doc = Chemicalml.parse(xml, schema: :schema3)
      atoms = doc.molecules.first.atom_array.atoms
      expect(atoms.size).to eq(2)
      expect(atoms.map(&:id)).to eq(%w[a1 a2])
    end
  end
end
