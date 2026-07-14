# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Symmetry < Lutaml::Model::Serializable
        include Base::Symmetry
        include Visitable
        extend Context
      end
    end
  end
end
