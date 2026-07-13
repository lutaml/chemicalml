# frozen_string_literal: true

module Chemicalml
  module Model
    # A one-dimensional array of values.
    class Array < Node
      attr_accessor :id, :title, :dict_ref, :data_type, :units,
                    :size, :values

      def initialize(values:, data_type: nil, units: nil, size: nil,
                     id: nil, title: nil, dict_ref: nil)
        @values = values
        @data_type = data_type
        @units = units
        @size = size
        @id = id
        @title = title
        @dict_ref = dict_ref
      end

      def value_attributes
        { values: values, data_type: data_type, units: units,
          size: size, id: id, title: title, dict_ref: dict_ref }
      end
    end
  end
end
