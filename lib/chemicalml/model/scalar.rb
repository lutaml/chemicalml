# frozen_string_literal: true

module Chemicalml
  module Model
    # A primitive scalar value with a data type and units.
    class Scalar < Node
      attr_accessor :id, :title, :dict_ref, :data_type, :units, :value

      def initialize(value:, data_type: nil, units: nil, id: nil,
                     title: nil, dict_ref: nil)
        @value = value
        @data_type = data_type
        @units = units
        @id = id
        @title = title
        @dict_ref = dict_ref
      end

      def value_attributes
        { value: value, data_type: data_type, units: units,
          id: id, title: title, dict_ref: dict_ref }
      end
    end
  end
end
