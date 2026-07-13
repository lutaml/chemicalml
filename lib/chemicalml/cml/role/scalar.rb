# frozen_string_literal: true

module Chemicalml
  module Cml
    module Role
      # Type marker for any wire class implementing the CML
      # <scalar> element, regardless of schema version.
      # Included by Schema3::Scalar and Schema24::Scalar.
      module Scalar
      end
    end
  end
end
