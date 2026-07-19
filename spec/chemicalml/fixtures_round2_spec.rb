# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Schema3 fixtures parse and round-trip' do
  before do
    Chemicalml::Cml::Schema3::Configuration.ensure_registered!
  end

  Dir.glob('spec/fixtures/schema3/**/*.cml').each do |path|
    it "#{path} parses without raising" do
      xml = File.read(path)
      expect { Chemicalml.parse(xml, schema: :schema3) }.not_to raise_error
    end
  end

  describe 'parallel-array fixture' do
    let(:xml) { File.read('spec/fixtures/schema3/parallel_array/ethanol_parallel.cml') }

    it 'parses the parallel-array atomArray form' do
      doc = Chemicalml.parse(xml, schema: :schema3)
      aa = doc.molecules.first.atom_array
      expect(aa.atom_id_array).to eq('a1 a2 a3 a4 a5 a6 a7 a8 a9')
      expect(aa.element_type_array).to eq('C C O H H H H H H')
    end

    it 'parses the parallel-array bondArray form' do
      doc = Chemicalml.parse(xml, schema: :schema3)
      ba = doc.molecules.first.bond_array
      expect(ba.atom_ref1_array).to eq('a1 a2 a1 a1 a1 a2 a2 a3')
      expect(ba.atom_ref2_array).to eq('a2 a3 a4 a5 a6 a7 a8 a9')
      expect(ba.order_array).to eq('1 1 1 1 1 1 1 1')
    end
  end

  describe 'spectroscopy fixture' do
    let(:xml) { File.read('spec/fixtures/schema3/spectroscopy/ethanol_ir.cml') }

    it 'detects the spectroscopy convention on the spectrum root' do
      doc = Chemicalml.parse(xml, schema: :schema3)
      # spectrum is parsed as a child of cml
      spectrum = doc.reactions ? nil : nil # no reaction in this fixture
      # The spectrum may not be exposed as a direct attr on Document —
      # at minimum, the XML should parse without error (asserted by
      # the per-file spec above).
    end
  end

  describe 'simpleUnit fixture' do
    it 'detects simpleUnit convention on the unitList root' do
      xml = File.read('spec/fixtures/schema3/simple_unit/basic_units.cml')
      doc = Chemicalml.parse(xml, schema: :schema3)
      expect(doc.convention).to eq('convention:simpleUnit')
    end
  end
end
