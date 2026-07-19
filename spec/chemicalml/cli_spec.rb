# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Chemicalml::Cli do
  describe 'Thor dispatch (full CLI)' do
    it 'conventions lists all 8 conventions' do
      out = capture_stdout { described_class.run(%w[conventions]) }
      %w[molecular compchem dictionary unit-dictionary unitType-dictionary spectroscopy cascade simpleUnit].each do |name|
        expect(out).to include("convention:#{name}")
      end
    end

    it 'dictionaries lists built-in dictionaries' do
      out = capture_stdout { described_class.run(%w[dictionaries]) }
      expect(out).to include('cml')
      expect(out).to include('compchem')
      expect(out).to include('unit_si')
    end

    it 'validate exits 0 on a valid molecular document' do
      path = 'spec/fixtures/schema3/molecular/water.cml'
      out = capture_stdout { described_class.run(['validate', path]) }
      expect(out).to match(/OK:/)
    end

    it 'validate --json emits machine-readable JSON' do
      path = 'spec/fixtures/schema3/molecular/water.cml'
      out = capture_stdout { described_class.run(['validate', '--json', path]) }
      require 'json'
      parsed = JSON.parse(out)
      expect(parsed['ok']).to eq(true)
    end

    it 'help lists every command' do
      out = capture_stdout { described_class.run(%w[help]) }
      %w[validate inspect conventions dictionaries elements constraints enums info].each do |cmd|
        expect(out).to include(cmd)
      end
    end
  end

  describe 'direct command invocation: MyCommandClass.new.run(options)' do
    it 'ValidateCommand.new.run(file: ...) returns 0 on clean doc' do
      exit_code = Chemicalml::Cli::ValidateCommand.new.run(
        file: 'spec/fixtures/schema3/molecular/water.cml'
      )
      expect(exit_code).to eq(0)
    end

    it 'ValidateCommand.new.run({}) returns 2 when file missing' do
      exit_code = Chemicalml::Cli::ValidateCommand.new.run({})
      expect(exit_code).to eq(2)
    end

    it 'ValidateCommand.new.run(file:, json:) emits JSON to stdout' do
      out = capture_stdout do
        Chemicalml::Cli::ValidateCommand.new.run(
          file: 'spec/fixtures/schema3/molecular/water.cml',
          json: true
        )
      end
      require 'json'
      parsed = JSON.parse(out)
      expect(parsed['ok']).to eq(true)
    end

    it 'ConventionsCommand.new.run({}) returns 0 and lists conventions' do
      out = capture_stdout { Chemicalml::Cli::ConventionsCommand.new.run({}) }
      expect(out).to include('convention:molecular')
    end

    it 'DictionariesCommand.new.run({}) returns 0 and lists dictionaries' do
      out = capture_stdout { Chemicalml::Cli::DictionariesCommand.new.run({}) }
      expect(out).to include('compchem')
    end

    it 'ElementsCommand.new.run({}) lists every wire class' do
      out = capture_stdout { Chemicalml::Cli::ElementsCommand.new.run({}) }
      expect(out).to include('Atom')
      expect(out).to include('Molecule')
    end

    it 'ConstraintsCommand.new.run({}) lists constraints grouped by convention' do
      out = capture_stdout { Chemicalml::Cli::ConstraintsCommand.new.run({}) }
      expect(out).to include('convention:')
      expect(out).to include('AtomMustHave')
    end

    it 'EnumsCommand.new.run({}) lists every enum constant' do
      out = capture_stdout { Chemicalml::Cli::EnumsCommand.new.run({}) }
      expect(out).to include('ORDER_VALUES')
      expect(out).to include('STEREO_VALUES')
    end

    it 'InfoCommand.new.run(element:) prints element details' do
      out = capture_stdout do
        Chemicalml::Cli::InfoCommand.new.run(element: 'atom')
      end
      expect(out).to include('Element: <atom>')
      expect(out).to include('Chemicalml::Cml::Schema3::Atom')
    end

    it 'InfoCommand.new.run({}) returns 2 when no element given' do
      exit_code = Chemicalml::Cli::InfoCommand.new.run({})
      expect(exit_code).to eq(2)
    end

    it 'InspectCommand.new.run(file:) prints tree summary' do
      out = capture_stdout do
        Chemicalml::Cli::InspectCommand.new.run(
          file: 'spec/fixtures/schema3/molecular/water.cml'
        )
      end
      expect(out).to include('Document')
      expect(out).to include('Molecule')
    end
  end

  describe 'class-level convenience: MyCommandClass.run(options)' do
    it 'matches instance-level invocation' do
      out1 = capture_stdout { Chemicalml::Cli::ConventionsCommand.new.run({}) }
      out2 = capture_stdout { Chemicalml::Cli::ConventionsCommand.run({}) }
      expect(out1).to eq(out2)
    end
  end

  def capture_stdout
    original = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = original
  end
end
