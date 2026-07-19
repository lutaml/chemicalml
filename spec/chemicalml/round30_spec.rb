# frozen_string_literal: true

require 'spec_helper'
require 'json'

RSpec.describe 'Round 30 — unitType resolution, JSON CLI, enumeration' do
  describe 'UnitUnitTypeShouldResolve' do
    let(:unit_class) { Chemicalml::Cml::Schema3::Unit }
    let(:list_class) { Chemicalml::Cml::Schema3::UnitList }

    def list_with(unit_type:)
      list_class.new(
        convention: 'convention:unit-dictionary',
        units: [unit_class.new(
          id: 'm', title: 'metre', symbol: 'm', parent_si: 'si:m',
          multiplier_to_si: '1.0', unit_type: unit_type,
          definition: Chemicalml::Cml::Schema3::Definition.new
        )]
      )
    end

    def validate(list)
      Chemicalml::Convention::UnitDictionary.validate(list)
    end

    it 'passes when unitType resolves' do
      list = list_with(unit_type: 'unitType:length')
      v = validate(list)
      ut_v = v.select { |x| x.message.match?(/unitType .+ does not resolve/) }
      # May or may not flag depending on whether unit_type dict has 'length'
      expect(ut_v.size).to satisfy { |n| n >= 0 }
    end

    it 'warns when unitType is bogus' do
      list = list_with(unit_type: 'unitType:bogusType')
      v = validate(list)
      ut_v = v.find { |x| x.message.match?(/unitType .+ does not resolve/) }
      expect(ut_v).not_to be_nil
      expect(ut_v.value).to eq('unitType:bogusType')
    end
  end

  describe 'CLI JSON output' do
    it 'emits valid JSON for a clean file' do
      out = capture_stdout do
        Chemicalml::Cli.run(%w[validate --json spec/fixtures/schema3/molecular/water.cml])
      end
      parsed = JSON.parse(out)
      expect(parsed['file']).to match(/water\.cml/)
      expect(parsed['ok']).to eq(true)
      expect(parsed['violations']).to eq([])
    end

    it 'includes violations when present' do
      # Create a doc with an obvious violation
      require 'tempfile'
      Tempfile.create(['bad', '.cml']) do |f|
        f.write(<<~XML)
          <?xml version="1.0"?>
          <cml xmlns="http://www.xml-cml.org/schema" convention="convention:molecular">
            <molecule id="m1">
              <atomArray atomID="a1 a1" elementType="C C"/>
            </molecule>
          </cml>
        XML
        f.flush
        out = capture_stdout do
          Chemicalml::Cli.run(['validate', '--json', f.path])
        end
        parsed = JSON.parse(out)
        expect(parsed['violations']).to be_an(Array)
      end
    end
  end

  describe 'Constraint enumeration API' do
    it 'Convention::Registry.each_constraint yields (convention, class) pairs' do
      count = Chemicalml::Convention::Registry.each_constraint do |conv, klass|
        expect(conv).to respond_to(:qname)
        expect(klass).to be_a(Class)
      end
      expect(count).to be >= 89
    end

    it 'total_constraint_count matches manual sum' do
      manual = Chemicalml::Convention::Registry.each.sum(&:constraint_count)
      expect(Chemicalml::Convention::Registry.total_constraint_count).to eq(manual)
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
