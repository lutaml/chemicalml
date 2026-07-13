# frozen_string_literal: true

module Chemicalml
  module Cml
    module Role
      # Type marker for any wire class implementing the CML
      # <identifier> element, regardless of schema version.
      # Included by Schema3::Identifier and Schema24::Identifier.
      module Identifier
      end
    end
  end
end
