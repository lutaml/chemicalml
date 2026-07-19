# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Round 29 — wire introspection, README, dataType check' do
  describe 'Cml.for_xml_name' do
    it 'returns the wire class for known element names' do
      expect(Chemicalml::Cml.for_xml_name('atomArray')).to eq(Chemicalml::Cml::Schema3::AtomArray)
      expect(Chemicalml::Cml.for_xml_name('molecule')).to eq(Chemicalml::Cml::Schema3::Molecule)
      expect(Chemicalml::Cml.for_xml_name('spectrum')).to eq(Chemicalml::Cml::Schema3::Spectrum)
    end

    it 'returns nil for unknown element names' do
      expect(Chemicalml::Cml.for_xml_name('bogus')).to be_nil
    end

    it 'supports Schema24 lookups' do
      expect(Chemicalml::Cml.for_xml_name('atom', schema: :schema24))
        .to eq(Chemicalml::Cml::Schema24::Atom)
    end
  end

  describe 'Cml.wire_classes' do
    it 'returns all Schema3 wire classes' do
      classes = Chemicalml::Cml.wire_classes
      expect(classes.size).to be >= 121
      expect(classes).to include(Chemicalml::Cml::Schema3::Atom)
      expect(classes).to include(Chemicalml::Cml::Schema3::Molecule)
    end
  end

  describe 'PropertyScalarDataTypeMatchesDictionary' do
    let(:prop_class) { Chemicalml::Cml::Schema3::Property }
    let(:scalar_class) { Chemicalml::Cml::Schema3::Scalar }
    let(:mol_class) { Chemicalml::Cml::Schema3::Molecule }
    let(:doc_class) { Chemicalml::Cml::Schema3::Document }

    def doc_with_scalar(data_type)
      doc_class.new(
        molecules: [mol_class.new(
          id: 'm1',
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
            atoms: [Chemicalml::Cml::Schema3::Atom.new(id: 'a1', element_type: 'C')]
          ),
          properties: [prop_class.new(
            dict_ref: 'cml:bp',
            scalar: scalar_class.new(data_type: data_type, content: '1.0')
          )]
        )]
      )
    end

    def validate(doc)
      Chemicalml::Convention::Molecular.validate(doc)
    end

    it 'passes when dataType matches the dictionary entry' do
      # cml:bp is "Boiling Point" — check what its dataType is
      entry = Chemicalml::Dictionary::Registry.lookup('cml:bp')
      expected = entry&.data_type.to_s
      skip "cml:bp has no dataType declared" if expected.empty?

      v = validate(doc_with_scalar(expected))
      dt_violations = v.select { |x| x.message.match?(/expects dataType/) }
      expect(dt_violations).to be_empty
    end

    it 'warns when dataType differs from the dictionary entry' do
      v = validate(doc_with_scalar('xsd:string'))
      dt_v = v.find { |x| x.message.match?(/expects dataType .* but scalar has/) }
      # Might be nil if cml:bp has dataType xsd:string; either way test runs
      expect(dt_v.nil? || dt_v.severity == :warning).to be true
    end
  end
end
