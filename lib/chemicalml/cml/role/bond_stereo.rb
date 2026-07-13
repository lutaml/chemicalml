# frozen_string_literal: true

module Chemicalml
  module Cml
    module Role
      # Type marker for any wire class implementing the CML
      # <bondstereo> element, regardless of schema version.
      # Included by Schema3::BondStereo and Schema24::BondStereo.
      module BondStereo
      end
    end
  end
end
