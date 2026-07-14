# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Crystal < Lutaml::Model::Serializable
        include Base::Crystal
        include Visitable
        extend Context
      end
    end
  end
end
