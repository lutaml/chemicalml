# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # A job module MUST have an `id` unique within the compchem
        # module.
        class JobModuleMustHaveId < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'A job module MUST have an `id` unique within the compchem module.'
          applies_to Chemicalml::Cml::Role::Module
          include ModulePredicates

          def check_node(node, path)
            return [] unless node.dict_ref == 'compchem:job'
            return [] unless node.id.to_s.empty?

            [violation(path: path.join('/'),
                       message: 'job module must have an id unique within the compchem module')]
          end
        end
      end
    end
  end
end
