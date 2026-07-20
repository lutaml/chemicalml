# frozen_string_literal: true

module Chemicalml
  module Convention
    module UnitDictionary
      module Constraints
        # A `<unitList>` element MUST contain one or more `<unit>`
        # children, and MUST NOT contain any other CML-namespace
        # child elements.
        class UnitListMustContainAtLeastOneUnit < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'A `<unitList>` element MUST contain one or more `<unit>` children, and MUST NOT contain any other CML-namespace child elements.'
          applies_to Chemicalml::Cml::Role::UnitList
          def check_node(node, path)
            return [] if (node.units || []).length.positive?

            [violation(path: path.join('/'),
                       message: 'unitList must contain at least one unit child')]
          end

          private

          def unit_list?(node)
            node.is_a?(Chemicalml::Cml::Role::UnitList)
          end
        end
      end
    end
  end
end
