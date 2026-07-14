# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Dimension < Lutaml::Model::Serializable
        include Base::Dimension
        include Visitable
        extend Context
      end
    end
  end
end
