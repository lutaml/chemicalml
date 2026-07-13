# frozen_string_literal: true

require "lutaml/model"

module Chemml
  module Cml
    # CML `<reactionList>` element. Container for `<reaction>` children.
    class ReactionList < Lutaml::Model::Serializable
      attribute :reactions, Reaction, collection: true

      xml do
        root "reactionList"
        map_element "reaction", to: :reactions
      end
    end
  end
end
