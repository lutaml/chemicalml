# frozen_string_literal: true

module Chemicalml
  module Model
    # A named property that wraps a value (scalar/array/matrix) and
    # points to a dictionary entry via `dict_ref`.
    class Property < Node
      attr_accessor :id, :title, :dict_ref, :convention, :value

      def initialize(value:, dict_ref:, id: nil, title: nil, convention: nil)
        @value = value
        @dict_ref = dict_ref
        @id = id
        @title = title
        @convention = convention
      end

      def children
        [value].compact
      end

      def value_attributes
        { id: id, title: title, dict_ref: dict_ref,
          convention: convention, value: value }
      end
    end
  end
end
