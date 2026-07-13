# frozen_string_literal: true

require "chemicalml/model/substance"

module ChemicalML
  module Model
      class Reactant < Node
        attr_accessor :substance

        def initialize(substance:)
          @substance = substance
        end

        def children
          [substance]
        end

        def value_attributes
          { substance: substance }
        end
      end
  end
end
