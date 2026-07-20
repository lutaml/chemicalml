# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # The environment module MUST NOT contain parameter or
        # parameterList children directly. It MAY contain a
        # propertyList (which itself can hold parameters).
        class EnvironmentMustNotContainParameter < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'The environment module MUST NOT contain parameter or parameterList children directly. It MAY contain a propertyList (which itself can hold parameters).'
          applies_to Chemicalml::Cml::Role::Module
          include ModulePredicates

          def check_node(node, path)
            violations = []
            unless (node.parameter_lists || []).empty?
              violations << violation(path: path.join('/'),
                                      message: 'environment module must not contain parameterList children ' \
                                               '(use propertyList instead)')
            end
            violations
          end
        end
      end
    end
  end
end
