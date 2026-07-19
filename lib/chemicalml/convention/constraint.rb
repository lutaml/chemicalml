# frozen_string_literal: true

module Chemicalml
  module Convention
    # Abstract base class for a single constraint. Subclasses implement
    # `check_node` (one node at a time) or `check` (whole document).
    #
    # A constraint subclass MAY declare `applies_to` — one or more
    # `Cml::Role::*` modules. When it does, the Coordinator only
    # invokes `check_node` for nodes matching that role. Without
    # `applies_to`, the constraint receives every node (legacy
    # behaviour). Declaring `applies_to` is the fast path: the
    # dispatch is O(node.ancestors) per node, not O(constraint_count).
    class Constraint
      class << self
        # Returns the Role module(s) this constraint applies to, or
        # nil if it must run for every node.
        def applies_to_roles
          @applies_to_roles
        end

        # Declare one or more Role modules this constraint handles.
        #   applies_to Chemicalml::Cml::Role::Atom
        #   applies_to Chemicalml::Cml::Role::Bond, Chemicalml::Cml::Role::AtomParity
        def applies_to(*roles)
          @applies_to_roles = roles.flatten.freeze
        end

        # Human-readable description of the rule this constraint
        # enforces. Subclasses MAY override. Falls back to the class
        # name. Used by `chemicalml constraints` and the auto-generated
        # constraint docs.
        #
        # @return [String]
        def description
          @description || name.split('::').last
        end

        # Set the description (DSL for subclasses).
        #   description "A <bond> must have an order attribute"
        def description=(value)
          @description = value
        end

        # Severity this constraint emits. Subclasses MAY override.
        # Default `:error` — warning subclasses override to `:warning`.
        #
        # @return [Symbol] `:error` or `:warning`.
        def default_severity
          :error
        end
      end

      def initialize
        freeze
      end

      def check(_document)
        raise NotImplementedError,
              "#{self.class} must implement #check(document)"
      end

      protected

      def violation(path:, message:, severity: :error, value: nil)
        Violation.new(path: path, message: message,
                      severity: severity, constraint: self.class,
                      value: value)
      end

      # Walk every wire node reachable from `node`. Yields (node, path)
      # pairs. Path is a slash-joined breadcrumb. Nodes that don't
      # include `Chemicalml::Cml::Visitable` are skipped.
      #
      # Iterative (worklist) implementation — does not recurse, so
      # deeply-nested documents cannot overflow the stack. Traversal
      # order is DFS pre-order, matching the prior recursive walker.
      def walk_nodes(node, path = [])
        return unless node
        return unless visitable?(node)

        worklist = [[node, path]]
        until worklist.empty?
          current, current_path = worklist.shift
          yield(current, current_path)
          current.wire_children.reverse_each do |child|
            next unless visitable?(child)

            worklist.unshift([child, current_path + [describe(child)]])
          end
        end
      end

      def visitable?(node)
        node.is_a?(Chemicalml::Cml::Visitable)
      end

      def describe(node)
        id_value = node.node_id
        id_value ? "#{node.element_name}[#{id_value}]" : node.element_name
      end

      # NodeConstraint: walks the document tree once per node and
      # calls `check_node(node, path)`. Subclasses get traversal for
      # free plus declarative role dispatch via `applies_to`.
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

      # DocumentConstraint: operates on the whole document at once —
      # used for cross-cutting rules like "atom ids unique within
      # molecule". Walks the tree itself; not subject to dispatch.
      class DocumentConstraint < Constraint
      end
    end
  end
end
