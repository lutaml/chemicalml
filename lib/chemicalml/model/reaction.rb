# frozen_string_literal: true

require "chemicalml/model/reactant_list"
require "chemicalml/model/product_list"

module ChemicalML
  module Model
    # A chemical reaction. Reactants, products, arrow kind, optional
    # conditions (above / below the arrow).
    class Reaction < Node
      ARROWS = %i[forward reverse equilibrium resonance].freeze

      attr_accessor :id, :reactant_list, :product_list, :arrow,
                    :conditions_above, :conditions_below, :title, :type

      def initialize(id: nil, reactant_list:, product_list:,
                     arrow: :forward, conditions_above: nil,
                     conditions_below: nil, title: nil, type: nil)
        @id = id
        @reactant_list = reactant_list
        @product_list = product_list
        @arrow = arrow
        @conditions_above = conditions_above
        @conditions_below = conditions_below
        @title = title
        @type = type
      end

      def children
        [reactant_list, product_list]
      end

      def value_attributes
        {
          id: id, reactant_list: reactant_list,
          product_list: product_list, arrow: arrow,
          conditions_above: conditions_above,
          conditions_below: conditions_below,
          title: title, type: type
        }
      end
    end
  end
end
