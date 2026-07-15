# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # A jobList module MUST have an `id` unique within the
        # compchem module.
        class JobListModuleMustHaveId < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Module
          include ModulePredicates

          def check_node(node, path)
            return [] unless node.dict_ref == 'compchem:jobList'
            return [] unless node.id.to_s.empty?

            [violation(path: path.join('/'),
                       message: 'jobList module must have an id unique within the compchem module')]
          end
        end
      end
    end
  end
end
