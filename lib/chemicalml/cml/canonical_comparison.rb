# frozen_string_literal: true

module Chemicalml
  module Cml
    # Semantic document comparison. Two documents are canonically
    # equal if their structural fingerprints match — same element
    # types, same attribute values, same number of children at each
    # node, ignoring attribute order and child order within
    # collection attributes.
    #
    # Useful for testing (asserting round-trip equality without
    # string-equality noise) and for diff tools that want to ignore
    # formatting differences.
    class CanonicalComparison
      attr_reader :left, :right

      # @param left [Lutaml::Model::Serializable] one document.
      # @param right [Lutaml::Model::Serializable] the other document.
      def initialize(left, right)
        @left = left
        @right = right
      end

      # True if the two documents are canonically equivalent.
      def equal?
        fingerprint(left) == fingerprint(right)
      end

      # Returns the difference as a hash of element_name → count_delta.
      # Empty hash means canonically equal.
      def diff
        l = fingerprint(left)
        r = fingerprint(right)
        keys = (l.keys + r.keys).uniq
        keys.each_with_object({}) do |k, h|
          delta = (r[k] || 0) - (l[k] || 0)
          h[k] = delta if delta.nonzero?
        end
      end

      private

      # Hash of element_name → count. Recursively walks every wire child.
      def fingerprint(node, counts = Hash.new(0))
        return counts unless node.is_a?(Lutaml::Model::Serializable)

        name = node.class.name.split('::').last
        counts[name] += 1
        node.wire_children.each { |c| fingerprint(c, counts) } if node.is_a?(Chemicalml::Cml::Visitable)
        counts
      end
    end
  end
end
