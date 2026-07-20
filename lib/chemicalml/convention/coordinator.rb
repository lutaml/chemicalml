# frozen_string_literal: true

module Chemicalml
  module Convention
    # Single-pass constraint dispatcher. Replaces the previous
    # O(N*C) walk (every constraint walked the whole tree) with
    # O(N + total_applicable) — one tree walk per validation, with
    # each node dispatched only to constraints that declared
    # `applies_to` matching one of the node's ancestors.
    #
    # Constraints that don't declare `applies_to` fall into a
    # default "all nodes" bucket and run for every visited node,
    # preserving backward compatibility.
    class Coordinator
      attr_reader :document_constraints, :node_constraints

      def initialize(constraint_classes)
        @document_constraints = constraint_classes
                                .select { |c| c < Constraint::DocumentConstraint }
                                .map(&:new)
        @node_constraints = constraint_constraints(constraint_classes)
                            .map(&:new)
        @always_applicable = []
        @by_role = Hash.new { |h, k| h[k] = [] }
        @node_constraints.each { |c| register(c) }
      end

      def validate(document)
        violations = @document_constraints.flat_map do |constraint|
          Array(constraint.check(document))
        end
        return violations unless visitable?(document)

        walk(document) do |node, path|
          applicable_for(node).each do |constraint|
            violations.concat(Array(constraint.check_node(node, path)))
          end
        end
        violations
      end

      private

      def constraint_constraints(classes)
        classes.select { |c| c < Constraint::NodeConstraint }
      end

      def register(constraint)
        roles = constraint.class.applies_to_roles
        if roles.nil? || roles.empty?
          @always_applicable << constraint
        else
          roles.each { |role| @by_role[role] << constraint }
        end
      end

      def visitable?(node)
        node.is_a?(Chemicalml::Cml::Visitable)
      end

      def applicable_for(node)
        applicable = @always_applicable
        node.class.ancestors.each do |ancestor|
          next unless ancestor.is_a?(::Module)

          bucket = @by_role[ancestor]
          next unless bucket

          applicable += bucket
        end
        applicable
      end

      def walk(node, path = [], &block)
        return unless node
        return unless visitable?(node)

        yield(node, path)
        node.wire_children.each do |child|
          walk(child, path + [describe(child)], &block)
        end
      end

      def describe(node)
        id_value = node.node_id
        id_value ? "#{node.element_name}[#{id_value}]" : node.element_name
      end
    end
  end
end
