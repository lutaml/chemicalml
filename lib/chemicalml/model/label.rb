# frozen_string_literal: true

module Chemicalml
  module Model
    # A string label with a `dict_ref` pointing to a dictionary entry.
    class Label < Node
      attr_accessor :id, :value, :dict_ref, :convention

      def initialize(value:, dict_ref:, id: nil, convention: nil)
        @value = value
        @dict_ref = dict_ref
        @id = id
        @convention = convention
      end

      def value_attributes
        { value: value, dict_ref: dict_ref, id: id, convention: convention }
      end
    end
  end
end
