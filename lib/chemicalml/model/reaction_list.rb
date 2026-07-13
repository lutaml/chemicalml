# frozen_string_literal: true

require "chemicalml/model/reaction"

module ChemicalML
  module Model
    # A reaction cascade: ordered list of `Reaction` instances where
    # each step's products are the next step's reactants.
    class ReactionList < Node
      attr_accessor :reactions

      def initialize(reactions: [])
        @reactions = reactions
      end

      def children
        reactions
      end

      def value_attributes
        { reactions: reactions }
      end
    end
  end
end
