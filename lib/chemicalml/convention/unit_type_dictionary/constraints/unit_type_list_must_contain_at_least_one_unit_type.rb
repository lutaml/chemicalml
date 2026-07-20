# frozen_string_literal: true

module Chemicalml
  module Convention
    module UnitTypeDictionary
      module Constraints
        # A `<unitTypeList>` MUST contain one or more `<unitType>`
        # children.
        class UnitTypeListMustContainAtLeastOneUnitType < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'A `<unitTypeList>` MUST contain one or more `<unitType>` children.'
          applies_to Chemicalml::Cml::Role::UnitTypeList
          def check_node(node, path)
            return [] if (node.unit_types || []).length.positive?

            [violation(path: path.join('/'),
                       message: 'unitTypeList must contain at least one unitType child')]
          end

          private

          def unit_type_list?(node)
            node.is_a?(Chemicalml::Cml::Role::UnitTypeList)
          end
        end
      end
    end
  end
end
