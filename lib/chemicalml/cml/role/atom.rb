# frozen_string_literal: true

module Chemicalml
  module Cml
    module Role
      # Type marker for any wire class implementing the CML
      # <atom> element, regardless of schema version.
      # Included by Schema3::Atom and Schema24::Atom.
      module Atom
      end
    end
  end
end
