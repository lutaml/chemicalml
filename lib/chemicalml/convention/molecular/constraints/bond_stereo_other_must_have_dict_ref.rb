# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # Molecular convention: `<bondStereo>` with value `other`
        # MUST have a `dictRef` pointing to the convention that
        # defines the stereo semantics.
        class BondStereoOtherMustHaveDictRef < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'Molecular convention: `<bondStereo>` with value `other` MUST have a `dictRef` pointing to the convention that defines the stereo semantics.'
          applies_to Chemicalml::Cml::Role::BondStereo
          def check_node(node, path)
            return [] unless node.content.to_s.downcase == 'other'
            return [] unless node.dict_ref.to_s.empty?

            [violation(
              path: (path + [describe(node)]).join('/'),
              message: "bondStereo value 'other' must have a dictRef " \
                       'identifying the convention that defines it'
            )]
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
