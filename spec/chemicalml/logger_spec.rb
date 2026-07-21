# frozen_string_literal: true

require 'spec_helper'
require 'stringio'

RSpec.describe Chemicalml::Logger do
  let(:io) { StringIO.new }
  let(:logger) { described_class.new(io) }

  it 'is a subclass of ::Logger' do
    expect(described_class.ancestors).to include(::Logger)
  end

  it 'writes info messages to the IO device' do
    logger.info 'hello'
    expect(io.string).to include('hello')
  end

  it 'writes error messages to the IO device' do
    logger.error 'bad'
    expect(io.string).to include('bad')
  end

  describe '.default' do
    it 'returns a logger at INFO level' do
      l = described_class.default
      expect(l.level).to eq(::Logger::INFO)
    end
  end

  describe 'Thor shell bridge' do
    let(:shell) { double('Thor::Shell') }

    before do
      allow(shell).to receive(:say)
      allow(shell).to receive(:say_error)
    end

    it 'routes info through Thor say' do
      logger.thor_shell = shell
      logger.info 'hello'
      expect(shell).to have_received(:say).with('hello')
    end

    it 'routes error through Thor say_error with red' do
      logger.thor_shell = shell
      logger.error 'bad'
      expect(shell).to have_received(:say_error).with('bad', :red)
    end

    it 'routes warn through Thor say_error with yellow' do
      logger.thor_shell = shell
      logger.warn 'meh'
      expect(shell).to have_received(:say_error).with('meh', :yellow)
    end

    it 'writes to IO when no thor_shell is set' do
      logger.info 'plain'
      expect(io.string).to include('plain')
    end
  end

  describe 'integration with Chemicalml.validate' do
    it 'logs validation progress when logger is provided' do
      Chemicalml::Cml::Schema3::Configuration.ensure_registered!
      doc = Chemicalml::Cml::Schema3::Document.new(
        convention: 'convention:molecular',
        molecules: [Chemicalml::Cml::Schema3::Molecule.new(
          id: 'm1',
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
            atoms: [Chemicalml::Cml::Schema3::Atom.new(id: 'a1', element_type: 'C')]
          )
        )]
      )
      l = described_class.new(io)
      Chemicalml.validate(doc, logger: l)
      expect(io.string).to include('Auto-detecting')
      expect(io.string).to include('Validation complete')
    end
  end
end
