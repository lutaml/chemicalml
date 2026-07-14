# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Map < Lutaml::Model::Serializable
        include Base::Map
        include Visitable
        extend Context
      end
    end
  end
end
