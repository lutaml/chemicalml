# frozen_string_literal: true

module Chemicalml
  module Convention
    module SimpleUnit
      module Constraints
        # A `<unit>` under simpleUnit MUST declare a `power` attribute
        # (integer). Without a power the unit's exponent is undefined.
        class UnitMustHavePower < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = "A `<unit>` under simpleUnit MUST declare a `power` attribute (integer). Without a power the unit's exponent is undefined."
          applies_to Chemicalml::Cml::Role::Unit

          def check_node(node, _path)
            power = node.power.to_s.strip
            return [] unless power.empty?

            [violation(path: yield_path(node),
                       message: "unit #{node.id.inspect} must declare a power attribute",
                       value: node.power)]
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
