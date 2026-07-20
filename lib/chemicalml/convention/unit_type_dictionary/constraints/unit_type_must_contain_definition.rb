# frozen_string_literal: true

module Chemicalml
  module Convention
    module UnitTypeDictionary
      module Constraints
        # A `<unitType>` MUST contain a single `<definition>` child
        # with XHTML content.
        class UnitTypeMustContainDefinition < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'A `<unitType>` MUST contain a single `<definition>` child with XHTML content.'
          applies_to Chemicalml::Cml::Role::UnitType
          def check_node(node, path)
            return [] unless node.definition.to_s.strip.empty?

            [violation(path: path.join('/'),
                       message: "unitType #{node.id.inspect} must contain a single definition child")]
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
