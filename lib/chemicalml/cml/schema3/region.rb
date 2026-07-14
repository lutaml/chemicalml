# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Region < Lutaml::Model::Serializable
        include Base::Region
        include Visitable
        extend Context
      end
    end
  end
end
