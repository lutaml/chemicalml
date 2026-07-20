# frozen_string_literal: true

module Chemicalml
  module Convention
    module UnitDictionary
      module Constraints
        # A `<unit>` element MUST have an `id` attribute, unique
        # within the unitList.
        class UnitMustHaveId < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'A `<unit>` element MUST have an `id` attribute, unique within the unitList.'
          applies_to Chemicalml::Cml::Role::Unit
          def check_node(node, path)
            return [] unless node.id.to_s.empty?

            [violation(path: path.join('/'),
                       message: 'unit must have an id attribute unique within the unitList')]
          end

          private

          def unit?(node)
            node.is_a?(Chemicalml::Cml::Role::Unit)
          end
        end
      end
    end
  end
end
