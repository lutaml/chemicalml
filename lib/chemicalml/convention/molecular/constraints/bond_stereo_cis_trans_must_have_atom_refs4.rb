# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # Molecular convention: `<bondStereo>` value C (cis) or T
        # (trans) MUST have `atomRefs4` and MUST NOT have `atomRefs2`.
        class BondStereoCisTransMustHaveAtomRefs4 < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'Molecular convention: `<bondStereo>` value C (cis) or T (trans) MUST have `atomRefs4` and MUST NOT have `atomRefs2`.'
          applies_to Chemicalml::Cml::Role::BondStereo
          CIS_TRANS_VALUES = %w[C T].freeze

          def check_node(node, path)
            value = node.content.to_s.upcase
            return [] unless CIS_TRANS_VALUES.include?(value)

            violations = []
            if node.atom_refs4.to_s.strip.empty?
              violations << violation(
                path: (path + [describe(node)]).join('/'),
                message: "bondStereo value #{value.inspect} must have atomRefs4 " \
                         '(four atom ids; two must match the parent bond)'
              )
            end
            unless node.atom_refs2.to_s.strip.empty?
              violations << violation(
                path: (path + [describe(node)]).join('/'),
                message: "bondStereo value #{value.inspect} must not have atomRefs2 " \
                         '(only W/H wedge/hatch values use atomRefs2)'
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
