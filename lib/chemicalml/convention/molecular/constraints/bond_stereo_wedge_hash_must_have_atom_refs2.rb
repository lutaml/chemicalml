# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # Molecular convention: `<bondStereo>` value W (wedge) or H
        # (hatch) MUST have `atomRefs2` and MUST NOT have `atomRefs4`.
        class BondStereoWedgeHashMustHaveAtomRefs2 < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::BondStereo
          WEDGE_HASH_VALUES = %w[W H].freeze

          def check_node(node, path)

            value = node.content.to_s.upcase
            return [] unless WEDGE_HASH_VALUES.include?(value)

            violations = []
            if node.atom_refs2.to_s.strip.empty?
              violations << violation(
                path: (path + [describe(node)]).join('/'),
                message: "bondStereo value #{value.inspect} must have atomRefs2 " \
                         '(first atom = sharp end, second = blunt end)'
              )
            end
            unless node.atom_refs4.to_s.strip.empty?
              violations << violation(
                path: (path + [describe(node)]).join('/'),
                message: "bondStereo value #{value.inspect} must not have atomRefs4 " \
                         '(only C/T cis-trans values use atomRefs4)'
              )
            end
            violations
          end

          private

          def bond_stereo?(node)
            node.is_a?(Chemicalml::Cml::Role::BondStereo)
          end
        end
      end
    end
  end
end
