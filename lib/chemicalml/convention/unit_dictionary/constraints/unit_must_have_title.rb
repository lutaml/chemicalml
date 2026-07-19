# frozen_string_literal: true

module Chemicalml
  module Convention
    module UnitDictionary
      module Constraints
        # A `<unit>` element MUST have a `title` attribute (the full
        # human-readable name of the unit). Per the unit-dictionary
        # convention spec.
        class UnitMustHaveTitle < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Unit

          def check_node(node, _path)
            return [] unless node.title.to_s.strip.empty?

            [violation(path: yield_path(node),
                       message: "unit #{node.id.inspect} must have a title attribute " \
                                '(the full human-readable name of the unit)')]
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
