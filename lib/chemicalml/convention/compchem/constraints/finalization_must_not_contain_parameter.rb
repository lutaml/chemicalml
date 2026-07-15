# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # The finalization module MUST NOT contain parameter or
        # parameterList children directly. (Parameters belong in
        # initialization.)
        class FinalizationMustNotContainParameter < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Module
          include ModulePredicates

          def check_node(node, path)

            violations = []
            unless (node.parameter_lists || []).empty?
              violations << violation(path: path.join('/'),
                                      message: 'finalization module must not contain parameterList children')
            end
            violations
          end
        end
      end
    end
  end
end
