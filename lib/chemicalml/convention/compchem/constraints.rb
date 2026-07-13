# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        autoload :CompchemModuleMustContainJobList,
                 "chemicalml/convention/compchem/constraints/compchem_module_must_contain_job_list"
        autoload :JobMustContainInitialization,
                 "chemicalml/convention/compchem/constraints/job_must_contain_initialization"
      end
    end
  end
end
