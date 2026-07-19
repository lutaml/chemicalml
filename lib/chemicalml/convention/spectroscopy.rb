# frozen_string_literal: true

module Chemicalml
  module Convention
    # The Spectroscopy convention. A chemicalml-specific convention for
    # CML spectroscopy data (`<spectrum>`, `<peakList>`, `<peak>`).
    #
    # Upstream CML does not define a spectroscopy convention; the wire
    # elements exist in the XSD but no constraints guard their
    # well-formedness. This convention covers the gaps:
    #
    # - spectra MUST declare their own convention (per the molecular
    #   convention's "each spectrum MUST specify its own convention")
    # - spectra MUST have a format (e.g. "mass", "ir", "nmr")
    # - spectra MUST contain at least one of xaxis/yaxis/peakList
    # - peakList MUST contain at least one peak/peakGroup
    # - peaks SHOULD have at least one of xValue/yValue (warning)
    module Spectroscopy
      extend Base

      autoload :Constraints, 'chemicalml/convention/spectroscopy/constraints'

      QNAME = 'convention:spectroscopy'
      NAMESPACE_URI = "#{Chemicalml::Convention::CONVENTION_NAMESPACE}spectroscopy".freeze

      def self.qname
        QNAME
      end

      def self.namespace_uri
        NAMESPACE_URI
      end

      register Constraints::SpectrumMustHaveConvention
      register Constraints::SpectrumMustHaveFormat
      register Constraints::SpectrumMustHaveContent
      register Constraints::PeakListMustContainPeaks
      register Constraints::PeakShouldHaveValues
    end
  end
end
