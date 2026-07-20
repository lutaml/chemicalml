# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # A `<bondStereo>` with `atomRefs4` (used by C/T stereo)
        # SHOULD reference four distinct atom ids. Duplicate ids make
        # the stereo descriptor meaningless. Warning severity.
        class BondStereoAtomRefs4ShouldBeDistinct < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'A `<bondStereo>` with `atomRefs4` (used by C/T stereo) SHOULD reference four distinct atom ids. Duplicate ids make the stereo descriptor meaningless. Warning severity.'
          applies_to Chemicalml::Cml::Role::BondStereo

          def check_node(node, _path)
            ids = parse_refs(node.atom_refs4)
            return [] if ids.size < 2
            return [] if ids.uniq.size == ids.size

            duplicates = ids.group_by { |i| i }.select { |_, v| v.size > 1 }.keys
            [violation(path: yield_path(node),
                       message: "bondStereo #{node.id.inspect} atomRefs4 should reference four distinct atoms; " \
                                "duplicate ids: #{duplicates.inspect}",
                       severity: :warning,
                       value: node.atom_refs4)]
          end

          private

          def yield_path(node)
            id = node.node_id
            id ? "bondStereo[#{id}]" : 'bondStereo'
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
