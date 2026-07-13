# frozen_string_literal: true

module Chemicalml
  module Cml
    module Role
      # Type marker for any wire class implementing the CML
      # <reaction> element, regardless of schema version.
      # Included by Schema3::Reaction and Schema24::Reaction.
      module Reaction
      end
    end
  end
end
