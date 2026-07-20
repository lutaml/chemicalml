# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # An `<atom>`'s `elementType` attribute SHOULD be one of the
        # XSD elementTypeType enum values (the periodic table plus
        # the special "Du" dummy and "R" group placeholder). Warns
        # on typos like "Carb" or "X".
        class AtomElementTypeShouldBeInPeriodicTable < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = "An `<atom>`'s `elementType` attribute SHOULD be one of the XSD elementTypeType enum values (the periodic table plus the special \"Du\" dummy and \"R\" group placeholder). Warns"
          include Chemicalml::Cml::Enums

          applies_to Chemicalml::Cml::Role::Atom

          def check_node(node, _path)
            et = node.element_type.to_s.strip
            return [] if et.empty?
            return [] if ELEMENT_TYPE_VALUES.include?(et)

            [violation(path: yield_path(node),
                       message: "atom #{node.id.inspect} elementType #{et.inspect} should be one of " \
                                "the periodic table symbols (e.g. C, H, O, Fe) — got #{et.inspect}",
                       severity: :warning,
                       value: et)]
          end

          private

          def yield_path(node)
            id = node.node_id
            id ? "atom[#{id}]" : 'atom'
          end
        end
      end
    end
  end
end
