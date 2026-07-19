# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        autoload :ModulePredicates,
                 'chemicalml/convention/compchem/constraints/module_predicates'
        autoload :CompchemModuleMustContainJobList,
                 'chemicalml/convention/compchem/constraints/compchem_module_must_contain_job_list'
        autoload :JobMustContainInitialization,
                 'chemicalml/convention/compchem/constraints/job_must_contain_initialization'
        autoload :JobListModuleMustHaveId,
                 'chemicalml/convention/compchem/constraints/job_list_module_must_have_id'
        autoload :JobModuleMustHaveId,
                 'chemicalml/convention/compchem/constraints/job_module_must_have_id'
        autoload :JobModuleAtMostOneFinalization,
                 'chemicalml/convention/compchem/constraints/job_module_at_most_one_finalization'
        autoload :JobModuleAtMostOneEnvironment,
                 'chemicalml/convention/compchem/constraints/job_module_at_most_one_environment'
        autoload :CalculationRequiresFinalization,
                 'chemicalml/convention/compchem/constraints/calculation_requires_finalization'
        autoload :InitializationAtMostOneMolecule,
                 'chemicalml/convention/compchem/constraints/initialization_at_most_one_molecule'
        autoload :InitializationAtMostOneParameterList,
                 'chemicalml/convention/compchem/constraints/initialization_at_most_one_parameter_list'
        autoload :InitializationMustNotContainProperty,
                 'chemicalml/convention/compchem/constraints/initialization_must_not_contain_property'
        autoload :FinalizationAtMostOneMolecule,
                 'chemicalml/convention/compchem/constraints/finalization_at_most_one_molecule'
        autoload :FinalizationAtMostOnePropertyList,
                 'chemicalml/convention/compchem/constraints/finalization_at_most_one_property_list'
        autoload :FinalizationMustNotContainParameter,
                 'chemicalml/convention/compchem/constraints/finalization_must_not_contain_parameter'
        autoload :EnvironmentAtMostOnePropertyList,
                 'chemicalml/convention/compchem/constraints/environment_at_most_one_property_list'
        autoload :EnvironmentMustNotContainParameter,
                 'chemicalml/convention/compchem/constraints/environment_must_not_contain_parameter'
        autoload :ScalarUnits,
                 'chemicalml/convention/compchem/constraints/scalar_units'
        autoload :ArrayRules,
                 'chemicalml/convention/compchem/constraints/array_rules'
        autoload :MatrixRules,
                 'chemicalml/convention/compchem/constraints/matrix_rules'
        autoload :InitializationMustHaveContent,
                 'chemicalml/convention/compchem/constraints/initialization_must_have_content'
        autoload :FinalizationMustHaveContent,
                 'chemicalml/convention/compchem/constraints/finalization_must_have_content'
      end
    end
  end
end
