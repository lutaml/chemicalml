# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'spectroscopy convention constraints' do
  let(:spectrum_class)  { Chemicalml::Cml::Schema3::Spectrum }
  let(:peak_list_class) { Chemicalml::Cml::Schema3::PeakList }
  let(:peak_class)      { Chemicalml::Cml::Schema3::Peak }

  def validate(node)
    Chemicalml::Convention::Spectroscopy.validate(node)
  end

  describe 'registration' do
    it 'is registered under its QName' do
      expect(Chemicalml::Convention.lookup('convention:spectroscopy'))
        .to eq(Chemicalml::Convention::Spectroscopy)
    end

    it 'exposes the convention namespace' do
      expect(Chemicalml::Convention::Spectroscopy.namespace_uri)
        .to eq('http://www.xml-cml.org/convention/spectroscopy')
    end
  end

  describe 'SpectrumMustHaveConvention' do
    it 'flags a spectrum without a convention attribute' do
      spectrum = spectrum_class.new(id: 's1', format: 'ir')
      violations = validate(spectrum)
      expect(violations.map(&:message))
        .to include(match(/must declare its own convention attribute/))
    end

    it 'passes when the spectrum declares a convention' do
      spectrum = spectrum_class.new(id: 's1', format: 'ir',
                                    convention: 'convention:spectroscopy')
      violations = validate(spectrum)
      expect(violations.map(&:message))
        .not_to include(match(/must declare its own convention attribute/))
    end
  end

  describe 'SpectrumMustHaveFormat' do
    it 'flags a spectrum without a format attribute' do
      spectrum = spectrum_class.new(id: 's1',
                                    convention: 'convention:spectroscopy')
      violations = validate(spectrum)
      expect(violations.map(&:message))
        .to include(match(/must have a format attribute/))
    end

    it 'passes when the spectrum declares a format' do
      spectrum = spectrum_class.new(id: 's1', format: 'nmr',
                                    convention: 'convention:spectroscopy')
      violations = validate(spectrum)
      expect(violations.map(&:message))
        .not_to include(match(/must have a format attribute/))
    end
  end

  describe 'SpectrumMustHaveContent' do
    it 'flags a spectrum with no xaxis, yaxis, or peakList' do
      spectrum = spectrum_class.new(
        id: 's1', format: 'ir', convention: 'convention:spectroscopy'
      )
      violations = validate(spectrum)
      expect(violations.map(&:message))
        .to include(match(/must contain at least one of xaxis, yaxis, or peakList/))
    end

    it 'passes when the spectrum contains a peakList' do
      spectrum = spectrum_class.new(
        id: 's1', format: 'ir', convention: 'convention:spectroscopy',
        peak_list: peak_list_class.new(peaks: [peak_class.new(xValue: '1.0')])
      )
      violations = validate(spectrum)
      expect(violations.map(&:message))
        .not_to include(match(/must contain at least one of/))
    end
  end

  describe 'PeakListMustContainPeaks' do
    it 'flags an empty peakList' do
      spectrum = spectrum_class.new(
        id: 's1', format: 'ir', convention: 'convention:spectroscopy',
        peak_list: peak_list_class.new
      )
      violations = validate(spectrum)
      expect(violations.map(&:message))
        .to include(match(/peakList must contain at least one peak or peakGroup/))
    end

    it 'passes when the peakList has a peak' do
      spectrum = spectrum_class.new(
        id: 's1', format: 'ir', convention: 'convention:spectroscopy',
        peak_list: peak_list_class.new(peaks: [peak_class.new(xValue: '1.0')])
      )
      violations = validate(spectrum)
      expect(violations.map(&:message))
        .not_to include(match(/peakList must contain/))
    end
  end

  describe 'PeakShouldHaveValues' do
    it 'warns when a peak has neither xValue nor yValue' do
      spectrum = spectrum_class.new(
        id: 's1', format: 'ir', convention: 'convention:spectroscopy',
        peak_list: peak_list_class.new(peaks: [peak_class.new(id: 'p1')])
      )
      violations = validate(spectrum)
      warning = violations.find { |v| v.message.match?(/should have at least one of/) }
      expect(warning).not_to be_nil
      expect(warning.severity).to eq(:warning)
    end

    it 'passes when a peak has xValue' do
      spectrum = spectrum_class.new(
        id: 's1', format: 'ir', convention: 'convention:spectroscopy',
        peak_list: peak_list_class.new(
          peaks: [peak_class.new(id: 'p1', xValue: '2.5')]
        )
      )
      violations = validate(spectrum)
      expect(violations.map(&:message))
        .not_to include(match(/should have at least one of/))
    end
  end
end
