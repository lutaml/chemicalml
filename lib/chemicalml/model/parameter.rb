# frozen_string_literal: true

module Chemicalml
  module Model
    # An input parameter — same shape as Property, used for inputs.
    class Parameter < Node
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
