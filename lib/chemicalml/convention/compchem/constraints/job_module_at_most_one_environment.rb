# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # A job module MUST contain at most one environment module.
        class JobModuleAtMostOneEnvironment < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'A job module MUST contain at most one environment module.'
          applies_to Chemicalml::Cml::Role::Module
          include ModulePredicates

          def check_node(node, path)
            environments = child_modules_with(node, 'compchem:environment')
            return [] if environments.length <= 1

            [violation(path: path.join('/'),
                       message: 'job module must contain at most one environment ' \
                                "(found #{environments.length})")]
          end
        end
      end
    end
  end
end
