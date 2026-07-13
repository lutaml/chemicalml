# frozen_string_literal: true

module Chemicalml
  module Convention
    module UnitTypeDictionary
      module Constraints
        # Every unitType MUST have an `id` and a `name` attribute per
        # the unitType-dictionary convention.
        class UnitTypeMustHaveIdAndName < Chemicalml::Convention::Constraint::NodeConstraint
          def check_node(node, path)
            return [] unless unit_type?(node)

            violations = []
            if node.id.to_s.empty?
              violations << violation(path: path.join("/"),
                                      message: "unitType must have an id")
            end
            if node.name.to_s.empty?
              violations << violation(path: path.join("/"),
                                      message: "unitType must have a name")
            end
            violations
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
