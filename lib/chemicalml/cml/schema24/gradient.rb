# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Gradient < Lutaml::Model::Serializable
        include Base::Gradient
        include Visitable
        extend Context
      end
    end
  end
end
