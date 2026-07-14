# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Vector3 < Lutaml::Model::Serializable
        include Base::Vector3
        include Visitable
        extend Context
      end
    end
  end
end
