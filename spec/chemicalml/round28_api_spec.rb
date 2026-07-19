# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Round 28 — parse_file, custom conventions, compchem' do
  describe 'Chemicalml.parse_file' do
    it 'parses a file from disk' do
      doc = Chemicalml.parse_file('spec/fixtures/schema3/molecular/water.cml')
      expect(doc).to be_a(Chemicalml::Cml::Schema3::Document)
      expect(doc.molecules.first.id).to eq('m1')
    end

    it 'raises ArgumentError for missing files' do
      expect { Chemicalml.parse_file('nonexistent.cml') }.to raise_error(ArgumentError, /not found/)
    end

    it 'accepts a schema keyword' do
      Chemicalml::Cml::Schema24::Configuration.ensure_registered!
      doc = Chemicalml.parse_file('spec/fixtures/schema3/molecular/water.cml', schema: :schema3)
      expect(doc).to be_a(Chemicalml::Cml::Schema3::Document)
    end
  end

  describe 'Convention::Registry.register_custom' do
    let(:custom_convention) do
      Module.new do
        extend Chemicalml::Convention::Base

        def self.qname
          'convention:my-custom'
        end

        def self.namespace_uri
          'http://example.com/convention/my-custom'
        end
      end
    end

    after do
      Chemicalml::Convention::Registry.reset!
    end

    it 'registers a custom convention' do
      Chemicalml::Convention::Registry.register_custom(custom_convention)
      expect(Chemicalml::Convention::Registry.lookup('convention:my-custom'))
        .to be(custom_convention)
    end

    it 'raises ArgumentError when qname is nil' do
      bad = Module.new do
        extend Chemicalml::Convention::Base

        def self.qname; end
      end
      expect { Chemicalml::Convention::Registry.register_custom(bad) }
        .to raise_error(ArgumentError, /non-empty qname/)
    end

    it 'appears in builtin_qnames after registration' do
      Chemicalml::Convention::Registry.register_custom(custom_convention)
      expect(Chemicalml::Convention::Registry.builtin_qnames)
        .to include('convention:my-custom')
    end
  end

  describe 'New compchem constraints' do
    let(:mod_class) { Chemicalml::Cml::Schema3::Module }

    def compchem_doc(inner_modules:)
      mod_class.new(
        id: 'root',
        convention: 'convention:compchem',
        modules: inner_modules
      )
    end

    def job(modules: [])
      mod_class.new(id: 'j1', dict_ref: 'compchem:job', modules: modules)
    end

    def job_list(modules: [])
      mod_class.new(id: 'jl1', dict_ref: 'compchem:jobList', modules: modules)
    end

    def initialization
      mod_class.new(id: 'init1', dict_ref: 'compchem:initialization')
    end

    def finalization
      mod_class.new(id: 'fin1', dict_ref: 'compchem:finalization')
    end

    describe 'InitializationMustHaveContent' do
      it 'flags an empty initialization' do
        doc = compchem_doc(
          inner_modules: [job_list(modules: [job(modules: [initialization])])]
        )
        violations = Chemicalml::Convention::Compchem.validate(doc)
        init_v = violations.find { |v| v.message.match?(/initialization .* must contain/) }
        expect(init_v).not_to be_nil
      end

      it 'passes when initialization has a molecule' do
        init = mod_class.new(id: 'init1', dict_ref: 'compchem:initialization',
                             molecules: [Chemicalml::Cml::Schema3::Molecule.new(id: 'm1')])
        doc = compchem_doc(
          inner_modules: [job_list(modules: [job(modules: [init])])]
        )
        violations = Chemicalml::Convention::Compchem.validate(doc)
        init_v = violations.find { |v| v.message.match?(/initialization .* must contain/) }
        expect(init_v).to be_nil
      end
    end

    describe 'FinalizationMustHaveContent' do
      it 'flags an empty finalization' do
        doc = compchem_doc(
          inner_modules: [job_list(modules: [job(modules: [finalization])])]
        )
        violations = Chemicalml::Convention::Compchem.validate(doc)
        fin_v = violations.find { |v| v.message.match?(/finalization .* must contain/) }
        expect(fin_v).not_to be_nil
      end
    end
  end
end
