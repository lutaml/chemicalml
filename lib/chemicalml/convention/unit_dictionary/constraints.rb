# frozen_string_literal: true

module Chemicalml
  module Convention
    module UnitDictionary
      module Constraints
        autoload :UnitMustHaveSymbolAndUnitType,
                 'chemicalml/convention/unit_dictionary/constraints/unit_must_have_symbol_and_unit_type'
        autoload :UnitMustHaveId,
                 'chemicalml/convention/unit_dictionary/constraints/unit_must_have_id'
        autoload :UnitMustContainDefinition,
                 'chemicalml/convention/unit_dictionary/constraints/unit_must_contain_definition'
        autoload :UnitListMustHaveNamespace,
                 'chemicalml/convention/unit_dictionary/constraints/unit_list_must_have_namespace'
        autoload :UnitListMustContainAtLeastOneUnit,
                 'chemicalml/convention/unit_dictionary/constraints/unit_list_must_contain_at_least_one_unit'
        autoload :UnitMustHaveTitle,
                 'chemicalml/convention/unit_dictionary/constraints/unit_must_have_title'
        autoload :UnitMustHaveParentSi,
                 'chemicalml/convention/unit_dictionary/constraints/unit_must_have_parent_si'
        autoload :UnitMustHaveMultiplierOrConstantToSi,
                 'chemicalml/convention/unit_dictionary/constraints/unit_must_have_multiplier_or_constant_to_si'
        autoload :UnitUnitTypeShouldResolve,
                 'chemicalml/convention/unit_dictionary/constraints/unit_unit_type_should_resolve'
        autoload :UnitParentSiShouldResolve,
                 'chemicalml/convention/unit_dictionary/constraints/unit_parent_si_should_resolve'
      end
    end
  end
end
