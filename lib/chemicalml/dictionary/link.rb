# frozen_string_literal: true

module Chemicalml
  module Dictionary
    # One external link from an entry's description or definition.
    # Maps to the `xhtml:a` element in the original CML dictionary
    # entries.
    class Link
      attr_reader :rel, :href, :title

      def initialize(rel:, href:, title: nil)
        @rel = rel
        @href = href
        @title = title
        freeze
      end

      def value_attributes
        { rel: rel, href: href, title: title }.compact
      end

      def eql?(other)
        other.is_a?(Link) && value_attributes == other.value_attributes
      end
      alias == eql?

      def hash
        value_attributes.hash
      end
    end
  end
end
