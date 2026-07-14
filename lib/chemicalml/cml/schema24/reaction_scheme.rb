# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class ReactionScheme < Lutaml::Model::Serializable
        include Base::ReactionScheme
        include Visitable
        extend Context
      end
    end
  end
end
