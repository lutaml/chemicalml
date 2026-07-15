# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # Internal: helpers shared by every compchem constraint. Mixed
        # into each constraint class so the role + dictRef checks
        # live in one place (DRY).
        module ModulePredicates
          def cml_module?(node)
            node.is_a?(Chemicalml::Cml::Role::Module)
          end

          def compchem_root?(node)
            cml_module?(node) && node.convention == 'convention:compchem'
          end

          def job_list_module?(node)
            cml_module?(node) && node.dict_ref == 'compchem:jobList'
          end

          def job_module?(node)
            cml_module?(node) && node.dict_ref == 'compchem:job'
          end

          def initialization_module?(node)
            cml_module?(node) && node.dict_ref == 'compchem:initialization'
          end

          def calculation_module?(node)
            cml_module?(node) && node.dict_ref == 'compchem:calculation'
          end

          def finalization_module?(node)
            cml_module?(node) && node.dict_ref == 'compchem:finalization'
          end

          def environment_module?(node)
            cml_module?(node) && node.dict_ref == 'compchem:environment'
          end

          def child_modules_with(node, dict_ref)
            (node.modules || []).select { |m| m.dict_ref == dict_ref }
          end
        end
      end
    end
  end
end
