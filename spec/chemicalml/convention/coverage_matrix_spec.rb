# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Convention coverage matrix' do
  CONVENTIONS = [
    'convention:molecular',
    'convention:compchem',
    'convention:dictionary',
    'convention:unit-dictionary',
    'convention:unitType-dictionary',
    'convention:spectroscopy',
    'convention:cascade',
    'convention:simpleUnit'
  ].freeze

  CONVENTION_TO_ROOT = {
    'convention:molecular'           => proc { Chemicalml::Cml::Schema3::Document },
    'convention:compchem'            => proc { Chemicalml::Cml::Schema3::Module },
    'convention:dictionary'          => proc { Chemicalml::Cml::Schema3::Dictionary },
    'convention:unit-dictionary'     => proc { Chemicalml::Cml::Schema3::UnitList },
    'convention:unitType-dictionary' => proc { Chemicalml::Cml::Schema3::UnitTypeList },
    'convention:spectroscopy'        => proc { Chemicalml::Cml::Schema3::Spectrum },
    'convention:cascade'             => proc { Chemicalml::Cml::Schema3::ReactionScheme },
    'convention:simpleUnit'          => proc { Chemicalml::Cml::Schema3::UnitList }
  }.freeze

  before do
    Chemicalml::Cml::Schema3::Configuration.ensure_registered!
  end

  it 'registers 8 conventions' do
    expect(Chemicalml::Convention::Registry.builtin_qnames.size).to eq(8)
  end

  CONVENTIONS.each do |qname|
    describe qname do
      let(:conv) { Chemicalml::Convention.lookup(qname) }

      it 'has a QName' do
        expect(conv.qname).to eq(qname)
      end

      it 'has a namespace URI' do
        expect(conv.namespace_uri).to start_with('http://www.xml-cml.org/convention/')
      end

      it 'registers >=1 constraint' do
        expect(conv.constraint_count).to be >= 1
      end

      it 'has a spec file mentioning its module' do
        module_name = conv.name.split('::').last
        matches = Dir.glob('spec/chemicalml/convention/*.rb').any? do |f|
          File.read(f).include?(module_name) || File.read(f).include?(qname)
        end
        expect(matches).to be true
      end

      it 'is detectable from its root role' do
        root_class = CONVENTION_TO_ROOT[qname].call
        root = root_class.new(convention: qname)
        expect(Chemicalml::Convention::Detection.convention_of(root)).to eq(qname)
      end

      it 'runs detect_and_validate without raising' do
        root_class = CONVENTION_TO_ROOT[qname].call
        root = root_class.new(convention: qname)
        expect { Chemicalml::Convention.detect_and_validate(root) }.not_to raise_error
      end
    end
  end
end
