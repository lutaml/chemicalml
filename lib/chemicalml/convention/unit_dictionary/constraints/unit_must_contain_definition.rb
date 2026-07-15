# frozen_string_literal: true

module Chemicalml
  module Convention
    module UnitDictionary
      module Constraints
        # A `<unit>` element MUST contain a single `<definition>`
        # child element with XHTML content.
        class UnitMustContainDefinition < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Unit
          def check_node(node, path)
            return [] unless node.definition.to_s.strip.empty?

            [violation(path: path.join('/'),
                       message: "unit #{node.id.inspect} must contain a single definition child")]
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
