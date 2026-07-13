# frozen_string_literal: true

module Chemml
  module Model
    # An external identifier: InChI, SMILES, CAS-RN, etc. The
    # `convention` field tags the identifier kind.
    class Identifier < Node
      attr_accessor :value, :convention, :dict_ref

      def initialize(value:, convention: nil, dict_ref: nil)
        @value = value
        @convention = convention
        @dict_ref = dict_ref
      end

      def value_attributes
        { value: value, convention: convention, dict_ref: dict_ref }
      end
    end
  end
end
