# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # The initialization module MUST NOT contain property or
        # propertyList children directly. (Properties belong in
        # finalization.)
        class InitializationMustNotContainProperty < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Module
          include ModulePredicates

          def check_node(node, path)

            violations = []
            unless (node.property_lists || []).empty?
              violations << violation(path: path.join('/'),
                                      message: 'initialization module must not contain propertyList children ' \
                                               '(properties belong in finalization)')
            end
            violations
          end
        end
      end
    end
  end
end
