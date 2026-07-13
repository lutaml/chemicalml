# frozen_string_literal: true

module Chemicalml
  module Cml
    module Role
      # Type marker for any wire class implementing the CML
      # <molecule> element, regardless of schema version.
      # Included by Schema3::Molecule and Schema24::Molecule.
      module Molecule
      end
    end
  end
end
