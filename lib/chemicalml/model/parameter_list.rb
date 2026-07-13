# frozen_string_literal: true

module Chemicalml
  module Model
    # Container for `Parameter` instances.
    class ParameterList < Node
      attr_accessor :id, :title, :dict_ref, :parameters

      def initialize(parameters: [], id: nil, title: nil, dict_ref: nil)
        @parameters = parameters
        @id = id
        @title = title
        @dict_ref = dict_ref
      end

      def children
        parameters
      end

      def value_attributes
        { parameters: parameters, id: id, title: title, dict_ref: dict_ref }
      end
    end
  end
end
