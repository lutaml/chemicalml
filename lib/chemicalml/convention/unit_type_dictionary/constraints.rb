# frozen_string_literal: true

module Chemicalml
  module Convention
    module UnitTypeDictionary
      module Constraints
        autoload :UnitTypeMustHaveIdAndName,
                 'chemicalml/convention/unit_type_dictionary/constraints/unit_type_must_have_id_and_name'
        autoload :UnitTypeIdMustMatchPattern,
                 'chemicalml/convention/unit_type_dictionary/constraints/unit_type_id_must_match_pattern'
        autoload :UnitTypeMustContainDefinition,
                 'chemicalml/convention/unit_type_dictionary/constraints/unit_type_must_contain_definition'
        autoload :UnitTypeListMustHaveNamespace,
                 'chemicalml/convention/unit_type_dictionary/constraints/unit_type_list_must_have_namespace'
        autoload :UnitTypeListMustContainAtLeastOneUnitType,
                 'chemicalml/convention/unit_type_dictionary/constraints/unit_type_list_must_contain_at_least_one_unit_type'
      end
    end
  end
end
