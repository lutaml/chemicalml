# frozen_string_literal: true

module Chemicalml
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
