# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # Walks the document and warns on `<atomParity>` elements
        # whose parent `<atom>`'s id does not appear in atomRefs4.
        # The CML convention requires the parent atom to be one of
        # the four references (otherwise the parity is meaningless).
        #
        # DocumentConstraint because it needs to walk the tree and
        # track parent-child relationships.
        class AtomParityShouldIncludeParentAtom < Chemicalml::Convention::Constraint::DocumentConstraint
          def check(document)
            violations = []
            visit_with_parent(document, nil) do |node, parent|
              next unless atom_parity?(node)
              next unless atom?(parent)

              refs = parse_refs(node.atom_refs4)
              next if refs.empty?
              next if refs.include?(parent.id)

              violations << violation(
                path: "atom[#{parent.id}]/atomParity",
                message: "atomParity atomRefs4 #{refs.inspect} should include the parent atom id " \
                         "#{parent.id.inspect}",
                severity: :warning,
                value: node.atom_refs4
              )
            end
            violations
          end

          private

          def visit_with_parent(node, parent, &block)
            return unless node.is_a?(Lutaml::Model::Serializable)

            block.call(node, parent)
            return unless node.is_a?(Chemicalml::Cml::Visitable)

            node.wire_children.each { |c| visit_with_parent(c, node, &block) }
          end

          def atom_parity?(node)
            node.is_a?(Chemicalml::Cml::Role::AtomParity)
          end

          def atom?(node)
            node.is_a?(Chemicalml::Cml::Role::Atom)
          end

          def parse_refs(value)
            return [] if value.nil?

            value.to_s.split(/\s+/).reject(&:empty?)
          end
        end
      end
    end
  end
end
