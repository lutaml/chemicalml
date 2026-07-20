# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # The initialization module MUST NOT contain more than one
        # parameterList child.
        class InitializationAtMostOneParameterList < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'The initialization module MUST NOT contain more than one parameterList child.'
          applies_to Chemicalml::Cml::Role::Module
          include ModulePredicates

          def check_node(node, path)
            lists = node.parameter_lists || []
            return [] if lists.length <= 1

            [violation(path: path.join('/'),
                       message: 'initialization module must not contain more than ' \
                                "one parameterList (found #{lists.length})")]
          end
        end
      end
    end
  end
end
