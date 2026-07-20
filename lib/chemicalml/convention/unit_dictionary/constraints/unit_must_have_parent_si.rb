# frozen_string_literal: true

module Chemicalml
  module Convention
    module UnitDictionary
      module Constraints
        # A `<unit>` element MUST have a `parentSI` attribute — a
        # QName referencing the SI unit it derives from. Per the
        # unit-dictionary convention spec.
        class UnitMustHaveParentSi < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'A `<unit>` element MUST have a `parentSI` attribute — a QName referencing the SI unit it derives from. Per the unit-dictionary convention spec.'
          applies_to Chemicalml::Cml::Role::Unit

          def check_node(node, _path)
            return [] unless node.parent_si.to_s.strip.empty?

            [violation(path: yield_path(node),
                       message: "unit #{node.id.inspect} must have a parentSI attribute " \
                                '(QName referencing the parent SI unit)')]
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
