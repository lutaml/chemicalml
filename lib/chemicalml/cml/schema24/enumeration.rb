# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # Schema 2.4 only. `<enumeration>` declares a closed/open set of
      # values for a dictionary entry. Not in Schema 3 (Schema 3 uses
      # the `enum` attribute on `<entry>`).
      class Enumeration < Lutaml::Model::Serializable
        include Base::Enumeration
        include Visitable
        extend Context
      end
    end
  end
end
