# frozen_string_literal: true

module Chemicalml
  module Cml
    module Role
      # Type marker for any wire class implementing the CML
      # <bond> element, regardless of schema version.
      # Included by Schema3::Bond and Schema24::Bond.
      module Bond
      end
    end
  end
end
