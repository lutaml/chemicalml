# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # A CompChem module MUST contain at least one jobList module
        # child per the compchem convention.
        class CompchemModuleMustContainJobList < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'A CompChem module MUST contain at least one jobList module child per the compchem convention.'
          def check_node(node, path)
            return [] unless compchem_root?(node)

            job_lists = (node.modules || []).select { |m| m.dict_ref == 'compchem:jobList' }
            return [] unless job_lists.empty?

            [violation(path: path.join('/'),
                       message: 'compchem module must contain at least one jobList module')]
          end

          private

          def compchem_root?(node)
            module?(node) && node.convention == 'convention:compchem'
          end

          def module?(node)
            node.is_a?(Chemicalml::Cml::Role::Module)
          end
        end
      end
    end
  end
end
