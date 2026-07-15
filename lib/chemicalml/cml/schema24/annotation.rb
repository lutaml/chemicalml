# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # Schema 2.4 only. `<annotation>` wraps documentation for an
      # entry or element. Not in Schema 3.
      class Annotation < Lutaml::Model::Serializable
        include Base::Annotation
        include Visitable
        extend Context
      end
    end
  end
end
