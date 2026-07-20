# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # Molecular convention: `<bond>` with `order="other"` MUST
        # have a `dictRef` pointing to the dictionary that defines
        # the order semantics. The warning-level "should not be
        # numeric" rule is separate; this is the hard error.
        class BondOrderOtherMustHaveDictRef < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'Molecular convention: `<bond>` with `order="other"` MUST have a `dictRef` pointing to the dictionary that defines the order semantics. The warning-level "should not be'
          applies_to Chemicalml::Cml::Role::Bond
          def check_node(node, path)
            return [] unless node.order.to_s.downcase == 'other'
            return [] unless node.dict_ref.to_s.empty?

            [violation(
              path: (path + [describe(node)]).join('/'),
              message: "bond order 'other' must have a dictRef " \
                       'identifying the dictionary entry that defines it'
            )]
          end

          private

          def bond?(node)
            node.is_a?(Chemicalml::Cml::Role::Bond)
          end
        end
      end
    end
  end
end
