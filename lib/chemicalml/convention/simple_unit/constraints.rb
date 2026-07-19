# frozen_string_literal: true

module Chemicalml
  module Convention
    module SimpleUnit
      module Constraints
        autoload :RootMustBeUnitList,
                 'chemicalml/convention/simple_unit/constraints/root_must_be_unit_list'
        autoload :UnitMustHavePower,
                 'chemicalml/convention/simple_unit/constraints/unit_must_have_power'
        autoload :UnitMustHaveSymbol,
                 'chemicalml/convention/simple_unit/constraints/unit_must_have_symbol'
      end
    end
  end
end
