# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # A job module MUST contain exactly one initialization module
        # child per the compchem convention.
        class JobMustContainInitialization < Chemicalml::Convention::Constraint::NodeConstraint
          def check_node(node, path)
            return [] unless job_module?(node)

            modules = node.modules || []
            inits = modules.select { |m| m.dict_ref == "compchem:initialization" }
            return [] if inits.length == 1

            message = if inits.empty?
                        "job module must contain exactly one initialization module (found 0)"
                      else
                        "job module must contain exactly one initialization module (found #{inits.length})"
                      end
            [violation(path: path.join("/"), message: message)]
          end

          private

          def job_module?(node)
            module?(node) && node.dict_ref == "compchem:job"
          end

          def module?(node)
            node.is_a?(Chemicalml::Cml::Role::Module)
          end
        end
      end
    end
  end
end
