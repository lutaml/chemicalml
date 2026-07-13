# frozen_string_literal: true

module Chemicalml
  module Model
    # A molecule name. The `convention` field tags the naming scheme
    # (e.g. `"iupac:systematic"`, `"trivial"`).
    class Name < Node
      attr_accessor :content, :convention, :dict_ref

      def initialize(content:, convention: nil, dict_ref: nil)
        @content = content
        @convention = convention
        @dict_ref = dict_ref
      end

      def value_attributes
        { content: content, convention: convention, dict_ref: dict_ref }
      end
    end
  end
end
