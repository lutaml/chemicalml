# frozen_string_literal: true

module Chemicalml
  module Model
    # A single metadata key/value pair.
    class Metadata < Node
      attr_accessor :id, :name, :content, :convention, :title

      def initialize(name:, content:, id: nil, convention: nil, title: nil)
        @name = name
        @content = content
        @id = id
        @convention = convention
        @title = title
      end

      def value_attributes
        { name: name, content: content, id: id,
          convention: convention, title: title }
      end
    end
  end
end
