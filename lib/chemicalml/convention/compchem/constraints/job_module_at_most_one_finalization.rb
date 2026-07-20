# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # A job module MUST contain at most one finalization module.
        class JobModuleAtMostOneFinalization < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'A job module MUST contain at most one finalization module.'
          applies_to Chemicalml::Cml::Role::Module
          include ModulePredicates

          def check_node(node, path)
            finalizations = child_modules_with(node, 'compchem:finalization')
            return [] if finalizations.length <= 1

            [violation(path: path.join('/'),
                       message: 'job module must contain at most one finalization ' \
                                "(found #{finalizations.length})")]
          end
        end
      end
    end
  end
end
