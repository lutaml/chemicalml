# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Definition < Lutaml::Model::Serializable
        include Base::Definition
        include Visitable
        extend Context
      end
    end
  end
end
