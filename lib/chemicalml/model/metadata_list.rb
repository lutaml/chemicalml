# frozen_string_literal: true

module Chemicalml
  module Model
    # Container for `Metadata` instances.
    class MetadataList < Node
      attr_accessor :id, :title, :dict_ref, :metadata

      def initialize(metadata: [], id: nil, title: nil, dict_ref: nil)
        @metadata = metadata
        @id = id
        @title = title
        @dict_ref = dict_ref
      end

      def children
        metadata
      end

      def value_attributes
        { metadata: metadata, id: id, title: title, dict_ref: dict_ref }
      end
    end
  end
end
