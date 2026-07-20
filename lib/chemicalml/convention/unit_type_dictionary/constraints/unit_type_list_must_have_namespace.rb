# frozen_string_literal: true

module Chemicalml
  module Convention
    module UnitTypeDictionary
      module Constraints
        # A `<unitTypeList>` MUST have a `namespace` attribute (valid
        # URI, SHOULD end with `/` or `#`).
        class UnitTypeListMustHaveNamespace < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'A `<unitTypeList>` MUST have a `namespace` attribute (valid URI, SHOULD end with `/` or `#`).'
          applies_to Chemicalml::Cml::Role::UnitTypeList
          def check_node(node, path)
            violations = []
            ns = node.namespace.to_s
            if ns.empty?
              violations << violation(path: path.join('/'),
                                      message: 'unitTypeList must have a namespace attribute')
            elsif !ns.end_with?('/', '#')
              violations << violation(path: path.join('/'),
                                      message: "unitTypeList namespace #{ns.inspect} should end with / or #",
                                      severity: :warning)
            end
            violations
          end

          private

          def unit_type_list?(node)
            node.is_a?(Chemicalml::Cml::Role::UnitTypeList)
          end
        end
      end
    end
  end
end
