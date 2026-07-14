# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Angle < Lutaml::Model::Serializable
        include Base::Angle
        include Visitable
        extend Context
      end
    end
  end
end
