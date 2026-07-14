# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Particle < Lutaml::Model::Serializable
        include Base::Particle
        include Visitable
        extend Context
      end
    end
  end
end
