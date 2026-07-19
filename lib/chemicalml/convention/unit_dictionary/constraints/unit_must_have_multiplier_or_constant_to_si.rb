# frozen_string_literal: true

module Chemicalml
  module Convention
    module UnitDictionary
      module Constraints
        # A `<unit>` element MUST have at least one of `multiplierToSI`
        # or `constantToSI` — to define the conversion to the parent
        # SI unit. Per the unit-dictionary convention spec.
        class UnitMustHaveMultiplierOrConstantToSi < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Unit

          def check_node(node, _path)
            has_multiplier = !node.multiplier_to_si.to_s.strip.empty?
            has_constant = !node.constant_to_si.to_s.strip.empty?
            return [] if has_multiplier || has_constant

            [violation(path: yield_path(node),
                       message: "unit #{node.id.inspect} must have at least one of " \
                                'multiplierToSI or constantToSI to convert to parent SI')]
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
