# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Round 25 — element type, dictRef, summary' do
  let(:atom_class) { Chemicalml::Cml::Schema3::Atom }
  let(:mol_class)  { Chemicalml::Cml::Schema3::Molecule }
  let(:doc_class)  { Chemicalml::Cml::Schema3::Document }

  def doc_with_atom(et)
    doc_class.new(
      molecules: [
        mol_class.new(
          id: 'm1',
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
            atoms: [atom_class.new(id: 'a1', element_type: et)]
          )
        )
      ]
    )
  end

  def validate(doc)
    Chemicalml::Convention::Molecular.validate_report(doc)
  end

  describe Chemicalml::Cml::Enums::ELEMENT_TYPE_VALUES do
    it 'includes the periodic table' do
      expect(described_class).to include('C', 'H', 'O', 'Fe', 'Au', 'U')
    end

    it 'includes Du (dummy) and R (group placeholder)' do
      expect(described_class).to include('Du', 'R')
    end

    it 'has 120 entries (matches XSD elementTypeType)' do
      expect(described_class.size).to eq(120)
    end
  end

  describe 'AtomElementTypeShouldBeInPeriodicTable' do
    it 'passes for "C"' do
      v = validate(doc_with_atom('C'))
      expect(v.warnings.map(&:message)).not_to include(match(/elementType .+ should be one of/))
    end

    it 'warns for "Xx" (typo)' do
      v = validate(doc_with_atom('Xx'))
      et_v = v.warnings.find { |x| x.message.match?(/elementType .+ should be one of/) }
      expect(et_v).not_to be_nil
      expect(et_v.value).to eq('Xx')
    end

    it 'warns for "Carbon" (full name)' do
      v = validate(doc_with_atom('Carbon'))
      expect(v.warnings.map(&:message)).to include(match(/elementType "Carbon" should be one of/))
    end

    it 'accepts "Du" (dummy) and "R" (group)' do
      ['Du', 'R'].each do |et|
        v = validate(doc_with_atom(et))
        expect(v.warnings.map(&:message)).not_to include(match(/elementType .+ should be one of/))
      end
    end
  end

  describe 'DictRefShouldResolve' do
    let(:prop_class) { Chemicalml::Cml::Schema3::Property }

    def doc_with_property(dict_ref)
      doc_class.new(
        molecules: [
          mol_class.new(
            id: 'm1',
            atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
              atoms: [atom_class.new(id: 'a1', element_type: 'C')]
            ),
            properties: [prop_class.new(dict_ref: dict_ref,
                                        scalar: Chemicalml::Cml::Schema3::Scalar.new(content: '1.0'))]
          )
        ]
      )
    end

    it 'passes when dictRef resolves to a built-in dictionary entry' do
      v = validate(doc_with_property('cml:bp'))
      expect(v.warnings.map(&:message)).not_to include(match(/dictRef .+ does not resolve/))
    end

    it 'warns when dictRef is unknown' do
      v = validate(doc_with_property('cml:bpingpoint'))
      dict_v = v.warnings.find { |x| x.message.match?(/dictRef .+ does not resolve/) }
      expect(dict_v).not_to be_nil
      expect(dict_v.value).to eq('cml:bpingpoint')
    end

    it 'passes when dictRef is empty' do
      v = validate(doc_with_property(''))
      expect(v.warnings.map(&:message)).not_to include(match(/dictRef .+ does not resolve/))
    end
  end

  describe Chemicalml::Convention::ValidationReport do
    describe '#summary' do
      it 'returns "OK — no violations" when clean' do
        report = described_class.new([])
        expect(report.summary).to eq('OK — no violations')
      end

      it 'renders a multi-line summary with errors and warnings' do
        v1 = Chemicalml::Convention::Violation.new(path: 'a', message: 'bad', severity: :error)
        v2 = Chemicalml::Convention::Violation.new(path: 'b', message: 'meh', severity: :warning)
        report = described_class.new([v1, v2])
        s = report.summary
        expect(s).to include('Errors: 1, Warnings: 1')
        expect(s).to include('ERROR a: bad')
        expect(s).to include('WARN  b: meh')
      end

      it 'includes the value when present' do
        v = Chemicalml::Convention::Violation.new(path: 'a', message: 'bad', value: 'Xx',
                                                  severity: :warning)
        report = described_class.new([v])
        expect(report.summary).to include('(value="Xx")')
      end
    end
  end
end
