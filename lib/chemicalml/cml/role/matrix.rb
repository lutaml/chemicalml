# frozen_string_literal: true

module Chemicalml
  module Cml
    module Role
      # Type marker for any wire class implementing the CML
      # <matrix> element, regardless of schema version.
      # Included by Schema3::Matrix and Schema24::Matrix.
      module Matrix
      end
    end
  end
end
