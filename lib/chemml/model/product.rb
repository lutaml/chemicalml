# frozen_string_literal: true

require "chemml/model/substance"

module Chemml
  module Model
    class Product < Node
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
