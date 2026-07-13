# frozen_string_literal: true

module Chemicalml
  module Convention
    # Abstract base class for a single constraint. Subclasses implement
    # `check_node` (one node at a time) or `check_document` (whole
    # document at once). The base class provides traversal and
    # collection plumbing.
    #
    # To add a new constraint:
    #
    #   1. Subclass `Constraint::NodeConstraint` or
    #      `Constraint::DocumentConstraint`
    #   2. Implement `check_node` / `check_document`
    #   3. Register it on the convention: `register(MyConstraint)`
    #
    # No framework code changes.
    class Constraint
      def self.name_for_display
        to_s.split("::").last
      end

      def check(_document)
        raise NotImplementedError,
              "#{self.class.name_for_display} must implement #check(document)"
      end

      protected

      def violation(path:, message:, severity: :error)
        Violation.new(path: path, message: message,
                      severity: severity, constraint: self.class)
      end

      # Walk every wire node reachable from `node`. Yields (node, path)
      # pairs. Path is a slash-joined breadcrumb. Nodes that don't
      # include `Chemicalml::Cml::Visitable` are skipped.
      def walk_nodes(node, path = [], &block)
        return unless node
        return unless visitable?(node)

        yield(node, path)
        node.wire_children.each do |child|
          walk_nodes(child, path + [describe(child)], &block)
        end
      end

      def visitable?(node)
        node.is_a?(Chemicalml::Cml::Visitable)
      end

      def describe(node)
        id_value = node.node_id
        id_value ? "#{node.element_name}[#{id_value}]" : node.element_name
      end

      # Constraint that walks the document tree once per node and calls
      # `check_node(node, path)`. Subclasses get traversal for free.
      class NodeConstraint < Constraint
        def check(document)
          violations = []
          walk_nodes(document) do |node, path|
            violations.concat(Array(check_node(node, path)))
          end
          violations
        end

        def check_node(_node, _path)
          []
        end
      end

      # Constraint that operates on the whole document at once — used
      # for cross-cutting rules like "atom ids unique within molecule".
      class DocumentConstraint < Constraint
      end
    end
  end
end
