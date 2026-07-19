# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Chemicalml::Cml::Enums do
  it 'defines ORDER_VALUES matching the XSD orderType' do
    expect(described_class::ORDER_VALUES).to contain_exactly(
      'S', '1', 'D', '2', 'T', '3', 'A', 'unknown', 'other'
    )
  end

  it 'defines STEREO_VALUES matching the XSD stereoType' do
    expect(described_class::STEREO_VALUES).to contain_exactly(
      'C', 'T', 'W', 'H', 'undefined', 'other'
    )
  end

  it 'defines CHIRALITY_VALUES matching the XSD chiralityType' do
    expect(described_class::CHIRALITY_VALUES).to contain_exactly(
      'enantiomer', 'racemate', 'unknown', 'other'
    )
  end

  it 'defines LATTICE_VALUES matching the XSD latticeType' do
    expect(described_class::LATTICE_VALUES).to contain_exactly(
      'primitive', 'full', 'aCentred', 'other'
    )
  end

  it 'defines MATRIX_VALUES including the documented shapes' do
    expect(described_class::MATRIX_VALUES).to include(
      'rectangular', 'square', 'diagonal', 'unit', 'unitary',
      'rotation33', 'rotationTranslation43', 'homogeneous44'
    )
  end

  it 'defines STATE_VALUES matching the XSD stateType' do
    expect(described_class::STATE_VALUES).to include(
      'aqueous', 'gas', 'glass', 'liquid', 'solid', 'solution', 'other'
    )
  end

  it 'defines PEAKMULTIPLICITY_VALUES for NMR peak multiplicity' do
    expect(described_class::PEAKMULTIPLICITY_VALUES).to contain_exactly(
      'singlet', 'doublet', 'triplet', 'quartet', 'quintet',
      'sextuplet', 'multiplet', 'other'
    )
  end

  it 'defines SPECTRUMTYPE_VALUES' do
    expect(described_class::SPECTRUMTYPE_VALUES).to contain_exactly(
      'infrared', 'massSpectrum', 'NMR', 'UV/VIS', 'other'
    )
  end

  it 'defines REACTIONROLE_VALUES' do
    expect(described_class::REACTIONROLE_VALUES).to include(
      'complete', 'overall', 'rateDeterminingStep', 'step', 'steps', 'other'
    )
  end

  it 'all constants are frozen Sets' do
    constants = described_class.constants(false)
    expect(constants.size).to be >= 25
    constants.each do |name|
      value = described_class.const_get(name)
      expect(value).to be_a(Set), "#{name} should be a Set, got #{value.class}"
      expect(value).to be_frozen, "#{name} should be frozen"
    end
  end

  it 'matches the XSD exactly (no manual edits)' do
    # Parse the XSD and assert each enum matches
    require 'nokogiri'
    xsd = File.read('reference-docs/schemas/schema3/schema.xsd')
    doc = Nokogiri::XML(xsd)
    doc.xpath('//xsd:simpleType[@name]').each do |st|
      name = st['name']
      next if name =~ /elementType|dataType/
      enums = st.xpath('.//xsd:enumeration/@value').map(&:to_s)
      next if enums.empty?
      constant_name = name.sub(/Type$/, '').upcase + '_VALUES'
      expect(described_class.const_defined?(constant_name, false)).to be(true),
             "missing constant #{constant_name} for XSD type #{name}"
      expect(described_class.const_get(constant_name)).to eq(Set.new(enums).freeze),
             "#{constant_name} does not match XSD #{name}"
    end
  end
end
