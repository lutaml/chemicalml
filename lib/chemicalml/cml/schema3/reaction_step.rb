# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class ReactionStep < Lutaml::Model::Serializable
        include Base::ReactionStep
        include Visitable
        extend Context
      end
    end
  end
end
