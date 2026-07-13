# frozen_string_literal: true

require "chemicalml/model/reactant"

module ChemicalML
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
