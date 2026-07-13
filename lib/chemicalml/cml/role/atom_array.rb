# frozen_string_literal: true

module Chemicalml
  module Cml
    module Role
      # Type marker for any wire class implementing the CML
      # <atomarray> element, regardless of schema version.
      # Included by Schema3::AtomArray and Schema24::AtomArray.
      module AtomArray
      end
    end
  end
end
