# frozen_string_literal: true

module Chemicalml
  module Model
    # A two-dimensional rectangular matrix of values.
    class Matrix < Node
      attr_accessor :id, :title, :dict_ref, :data_type, :units,
                    :rows, :columns, :values

      def initialize(values:, rows:, columns:, data_type: nil, units: nil,
                     id: nil, title: nil, dict_ref: nil)
        @values = values
        @rows = rows
        @columns = columns
        @data_type = data_type
        @units = units
        @id = id
        @title = title
        @dict_ref = dict_ref
      end

      def value_attributes
        { values: values, rows: rows, columns: columns,
          data_type: data_type, units: units,
          id: id, title: title, dict_ref: dict_ref }
      end
    end
  end
end
