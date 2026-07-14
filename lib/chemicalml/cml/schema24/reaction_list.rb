# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # CML <reactionlist> wire class. See Chemicalml::Cml::Base::ReactionList
      # for the shared attribute + xml-mapping declarations.
      class ReactionList < Lutaml::Model::Serializable
        include Base::ReactionList
        include Visitable
        extend Context
      end
    end
  end
end
