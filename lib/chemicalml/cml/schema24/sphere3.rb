# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Sphere3 < Lutaml::Model::Serializable
        include Base::Sphere3
        include Visitable
        extend Context
      end
    end
  end
end
