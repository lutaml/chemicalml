# frozen_string_literal: true

module Chemicalml
  module Cml
    module Role
      # Type marker for any wire class implementing the CML
      # <substance> element, regardless of schema version.
      # Included by Schema3::Substance and Schema24::Substance.
      module Substance
      end
    end
  end
end
