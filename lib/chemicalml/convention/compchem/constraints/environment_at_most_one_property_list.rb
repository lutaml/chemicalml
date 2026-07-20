# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # The environment module MUST NOT contain more than one
        # propertyList child.
        class EnvironmentAtMostOnePropertyList < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'The environment module MUST NOT contain more than one propertyList child.'
          applies_to Chemicalml::Cml::Role::Module
          include ModulePredicates

          def check_node(node, path)
            lists = node.property_lists || []
            return [] if lists.length <= 1

            [violation(path: path.join('/'),
                       message: 'environment module must not contain more than ' \
                                "one propertyList (found #{lists.length})")]
          end
        end
      end
    end
  end
end
