# frozen_string_literal: true

require "lutaml/model"

module ChemicalML
  module Cml
    # Root `<cml>` element. A CML document holds zero or more
    # top-level `<molecule>` or `<reactionList>` children.
    #
    # The CML spec also allows top-level `<reaction>` without a
    # `<reactionList>` wrapper. This class models both shapes via
    # parallel collections.
    class Document < Lutaml::Model::Serializable
      attribute :molecules, Molecule, collection: true
      attribute :reaction_lists, ReactionList, collection: true
      attribute :reactions, Reaction, collection: true

      xml do
        root "cml"
        map_element "molecule", to: :molecules
        map_element "reactionList", to: :reaction_lists
        map_element "reaction", to: :reactions
      end
    end
  end
end
