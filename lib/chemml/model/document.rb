# frozen_string_literal: true

require "chemml/model/molecule"
require "chemml/model/reaction"
require "chemml/model/reaction_list"

module Chemml
  module Model
    # Top-level container: the canonical document. Parallel to
    # `AsciiChem::Model::Formula`. Holds an ordered list of
    # molecules, reactions, and reaction lists.
    class Document < Node
      attr_accessor :molecules, :reactions, :reaction_lists

      def initialize(molecules: [], reactions: [], reaction_lists: [])
        @molecules = molecules
        @reactions = reactions
        @reaction_lists = reaction_lists
      end

      def children
        molecules + reactions + reaction_lists
      end

      def value_attributes
        {
          molecules: molecules, reactions: reactions,
          reaction_lists: reaction_lists
        }
      end
    end
  end
end
