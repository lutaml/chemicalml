# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class AnyCml < Lutaml::Model::Serializable
        include Base::AnyCml
        include Visitable
        extend Context
      end
    end
  end
end
