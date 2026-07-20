# frozen_string_literal: true

module Chemicalml
  module Convention
    module SimpleUnit
      module Constraints
        # A `<unit>` under simpleUnit MUST declare a non-empty
        # `symbol` attribute. Without a symbol the unit cannot be
        # rendered in formulae.
        class UnitMustHaveSymbol < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'A `<unit>` under simpleUnit MUST declare a non-empty `symbol` attribute. Without a symbol the unit cannot be rendered in formulae.'
          applies_to Chemicalml::Cml::Role::Unit

          def check_node(node, _path)
            return [] unless node.symbol.to_s.strip.empty?

            [violation(path: yield_path(node),
                       message: "unit #{node.id.inspect} must declare a non-empty symbol attribute")]
          end

          private

          def yield_path(node)
            id = node.node_id
            id ? "unit[#{id}]" : 'unit'
          end
        end
      end
    end
  end
end
