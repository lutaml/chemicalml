# frozen_string_literal: true

module Chemicalml
  module Convention
    module Spectroscopy
      module Constraints
        autoload :SpectrumMustHaveConvention,
                 'chemicalml/convention/spectroscopy/constraints/spectrum_must_have_convention'
        autoload :SpectrumMustHaveFormat,
                 'chemicalml/convention/spectroscopy/constraints/spectrum_must_have_format'
        autoload :SpectrumMustHaveContent,
                 'chemicalml/convention/spectroscopy/constraints/spectrum_must_have_content'
        autoload :PeakListMustContainPeaks,
                 'chemicalml/convention/spectroscopy/constraints/peak_list_must_contain_peaks'
        autoload :PeakShouldHaveValues,
                 'chemicalml/convention/spectroscopy/constraints/peak_should_have_values'
      end
    end
  end
end
