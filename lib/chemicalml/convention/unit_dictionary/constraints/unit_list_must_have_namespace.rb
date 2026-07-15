# frozen_string_literal: true

module Chemicalml
  module Convention
    module UnitDictionary
      module Constraints
        # A `<unitList>` element MUST have a `namespace` attribute
        # whose value is a valid URI defining the scope within which
        # the unit ids are unique. SHOULD end with `/` or `#`.
        class UnitListMustHaveNamespace < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::UnitList
          def check_node(node, path)

            violations = []
            ns = node.namespace.to_s
            if ns.empty?
              violations << violation(path: path.join('/'),
                                      message: 'unitList must have a namespace attribute')
            elsif !ns.end_with?('/', '#')
              violations << violation(path: path.join('/'),
                                      message: "unitList namespace #{ns.inspect} should end with / or #",
                                      severity: :warning)
            end
            violations
          end

          private

          def unit_list?(node)
            node.is_a?(Chemicalml::Cml::Role::UnitList)
          end
        end
      end
    end
  end
end
