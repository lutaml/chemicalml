# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # An `<atomParity>` element's `atomRefs4` attribute SHOULD
        # reference four distinct atom ids around a chiral center.
        # Duplicate ids make the parity descriptor meaningless.
        # Warning severity.
        class AtomParityAtomRefs4ShouldBeDistinct < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::AtomParity

          def check_node(node, _path)
            ids = parse_refs(node.atom_refs4)
            return [] if ids.size < 2
            return [] if ids.uniq.size == ids.size

            duplicates = ids.group_by { |i| i }.select { |_, v| v.size > 1 }.keys
            [violation(path: yield_path(node),
                       message: "atomParity #{node.id.inspect} atomRefs4 should reference four distinct atoms; " \
                                "duplicate ids: #{duplicates.inspect}",
                       severity: :warning,
                       value: node.atom_refs4)]
          end

          private

          def yield_path(node)
            id = node.node_id
            id ? "atomParity[#{id}]" : 'atomParity'
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
