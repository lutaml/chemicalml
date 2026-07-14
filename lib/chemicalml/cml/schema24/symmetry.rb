# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Symmetry < Lutaml::Model::Serializable
        include Base::Symmetry
        include Visitable
        extend Context
      end
    end
  end
end
