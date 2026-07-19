# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # A `<bond>`'s `atomRefs2` SHOULD reference two distinct atom
        # ids. A self-bond (`a1 a1`) is chemically meaningless.
        # Warning severity — there are edge cases in non-classical
        # chemistry (e.g. agostic interactions).
        class BondAtomRefs2ShouldBeDistinct < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Bond

          def check_node(node, _path)
            ids = parse_refs(node.atom_refs2)
            return [] if ids.size < 2
            return [] if ids.uniq.size == ids.size

            duplicates = ids.group_by { |i| i }.select { |_, v| v.size > 1 }.keys
            [violation(path: yield_path(node),
                       message: "bond #{node.id.inspect} atomRefs2 should reference two distinct atoms; " \
                                "duplicate ids: #{duplicates.inspect}",
                       severity: :warning,
                       value: node.atom_refs2)]
          end

          private

          def yield_path(node)
            id = node.node_id
            id ? "bond[#{id}]" : 'bond'
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
