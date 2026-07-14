# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Object < Lutaml::Model::Serializable
        include Base::Object
        include Visitable
        extend Context
      end
    end
  end
end
