# frozen_string_literal: true

module Chemicalml
  module Convention
    module Dictionary
      module Constraints
        # Co-constraint between `unitType` and `units`:
        #
        # - If `unitType` is `unknown`, `units` MUST NOT be present.
        # - If `unitType` is `none`, `units` MUST be present and point
        #   to `http://www.xml-cml.org/unit/si#none`.
        class EntryUnitsCoConstraints < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::DictionaryEntry
          NONE_UNITS = 'http://www.xml-cml.org/unit/si#none'

          def check_node(node, path)

            unit_type = node.unit_type.to_s
            units = node.units.to_s
            violations = []

            if unit_type == 'unknown' && !units.empty?
              violations << violation(path: path.join('/'),
                                      message: "entry #{node.id.inspect} has unitType 'unknown' " \
                                               'and therefore must not have units')
            end
            if unit_type == 'none' && units != NONE_UNITS
              violations << violation(path: path.join('/'),
                                      message: "entry #{node.id.inspect} has unitType 'none' — " \
                                               "units must be #{NONE_UNITS.inspect}")
            end
            violations
          end

          private

          def entry?(node)
            node.is_a?(Chemicalml::Cml::Role::DictionaryEntry)
          end
        end
      end
    end
  end
end
