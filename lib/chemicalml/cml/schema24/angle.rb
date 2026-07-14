# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Angle < Lutaml::Model::Serializable
        include Base::Angle
        include Visitable
        extend Context
      end
    end
  end
end
