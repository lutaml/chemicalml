# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class AnyCml < Lutaml::Model::Serializable
        include Base::AnyCml
        include Visitable
        extend Context
      end
    end
  end
end
