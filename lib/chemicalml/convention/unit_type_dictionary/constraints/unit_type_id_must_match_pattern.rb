# frozen_string_literal: true

module Chemicalml
  module Convention
    module UnitTypeDictionary
      module Constraints
        # A `<unitType>` `id` MUST match `[A-Za-z][A-Za-z0-9._-]*`.
        class UnitTypeIdMustMatchPattern < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'A `<unitType>` `id` MUST match `[A-Za-z][A-Za-z0-9._-]*`.'
          applies_to Chemicalml::Cml::Role::UnitType
          PATTERN = /\A[A-Za-z][A-Za-z0-9._-]*\z/

          def check_node(node, path)
            id = node.id.to_s
            return [] if id.empty?
            return [] if id.match?(PATTERN)

            [violation(path: path.join('/'),
                       message: "unitType id #{id.inspect} must match [A-Za-z][A-Za-z0-9._-]*")]
          end

          private

          def unit_type?(node)
            node.is_a?(Chemicalml::Cml::Role::UnitType)
          end
        end
      end
    end
  end
end
