# frozen_string_literal: true

require "chemml/model/reactant"

module Chemml
  module Model
    class ReactantList < Node
      attr_accessor :reactants

      def initialize(reactants: [])
        @reactants = reactants
      end

      def children
        reactants
      end

      def value_attributes
        { reactants: reactants }
      end
    end
  end
end
