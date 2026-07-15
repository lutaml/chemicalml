# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # Schema 2.4 only. Not in Schema 3.
      class Arg < Lutaml::Model::Serializable
        include Base::Arg
        include Visitable
        extend Context
      end
    end
  end
end
