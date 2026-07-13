# frozen_string_literal: true

module Chemicalml
  module Cml
    module Role
      # Type marker for any wire class implementing the CML
      # <bondarray> element, regardless of schema version.
      # Included by Schema3::BondArray and Schema24::BondArray.
      module BondArray
      end
    end
  end
end
