# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Length < Lutaml::Model::Serializable
        include Base::Length
        include Visitable
        extend Context
      end
    end
  end
end
