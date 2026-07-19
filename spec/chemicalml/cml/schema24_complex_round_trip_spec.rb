# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Schema24 complex round-trip (TODO 98)' do
  before do
    Chemicalml::Cml::Schema24::Configuration.ensure_registered!
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

  describe 'parse → serialise → parse with a Schema24 document' do
    let(:xml) do
      <<~XML
        <?xml version="1.0"?>
        <cml xmlns="http://www.xml-cml.org/schema" convention="convention:molecular">
          <molecule id="ethanol" title="Ethanol">
            <atomArray atomID="a1 a2 a3 a4 a5 a6 a7 a8 a9"
                       elementType="C C O H H H H H H"
                       x3="1.18 0.0 1.30 1.95 2.0 -0.50 -0.50 1.95 -0.95"
                       y3="0.42 0.0 1.05 0.97 1.95 0.95 0.95 2.0 -0.95"
                       z3="0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0"
                       hydrogenCount="3 1 0 0 0 0 0 0 0"/>
            <bondArray atomRef1="a1 a2 a1 a1 a1 a2 a2 a3"
                       atomRef2="a2 a3 a4 a5 a6 a7 a8 a9"
                       bondID="b1 b2 b3 b4 b5 b6 b7 b8"
                       order="S S S S S S S S"/>
            <name>ethanol</name>
            <formula concise="C 2 H 6 O 1"/>
          </molecule>
        </cml>
      XML
    end

    it 'parses the document on Schema24' do
      doc = Chemicalml.parse(xml, schema: :schema24)
      expect(doc).to be_a(Chemicalml::Cml::Schema24::Document)
    end

    it 'round-trips with structural equality' do
      doc1 = Chemicalml.parse(xml, schema: :schema24)
      xml2 = doc1.to_xml
      doc2 = Chemicalml.parse(xml2, schema: :schema24)
      expect(fingerprint(doc2)).to eq(fingerprint(doc1))
    end

    it 'preserves parallel-array atomArray data' do
      doc = Chemicalml.parse(xml, schema: :schema24)
      mol = doc.molecules.first
      expect(mol.id).to eq('ethanol')
      aa = mol.atom_array
      expect(aa.atom_id_array).to eq('a1 a2 a3 a4 a5 a6 a7 a8 a9')
      expect(aa.element_type_array).to eq('C C O H H H H H H')
      expect(aa.hydrogen_count_array).to eq('3 1 0 0 0 0 0 0 0')
    end

    it 'preserves parallel-array bondArray data' do
      doc = Chemicalml.parse(xml, schema: :schema24)
      mol = doc.molecules.first
      ba = mol.bond_array
      expect(ba.atom_ref1_array).to eq('a1 a2 a1 a1 a1 a2 a2 a3')
      expect(ba.atom_ref2_array).to eq('a2 a3 a4 a5 a6 a7 a8 a9')
      expect(ba.order_array).to eq('S S S S S S S S')
    end

    it 'detects and validates the molecular convention on Schema24' do
      doc = Chemicalml.parse(xml, schema: :schema24)
      report = Chemicalml::Convention.detect_and_validate(doc)
      expect(report.errors).to eq([])
    end
  end

  describe 'cross-schema equivalence' do
    let(:xml) do
      <<~XML
        <?xml version="1.0"?>
        <cml xmlns="http://www.xml-cml.org/schema" convention="convention:molecular">
          <molecule id="m1">
            <atomArray atomID="a1 a2" elementType="C O"/>
            <bondArray atomRef1="a1" atomRef2="a2" order="S"/>
          </molecule>
        </cml>
      XML
    end

    it 'produces the same structural fingerprint on Schema3 and Schema24' do
      s3 = Chemicalml.parse(xml, schema: :schema3)
      s24 = Chemicalml.parse(xml, schema: :schema24)
      expect(fingerprint(s24)).to eq(fingerprint(s3))
    end
  end
end
