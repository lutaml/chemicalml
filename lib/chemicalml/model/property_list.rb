# frozen_string_literal: true

module Chemicalml
  module Model
    # Container for `Property` instances.
    class PropertyList < Node
      attr_accessor :id, :title, :dict_ref, :properties

      def initialize(properties: [], id: nil, title: nil, dict_ref: nil)
        @properties = properties
        @id = id
        @title = title
        @dict_ref = dict_ref
      end

      def children
        properties
      end

      def value_attributes
        { properties: properties, id: id, title: title, dict_ref: dict_ref }
      end
    end
  end
end
