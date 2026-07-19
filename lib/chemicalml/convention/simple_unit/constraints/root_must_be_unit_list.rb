# frozen_string_literal: true

module Chemicalml
  module Convention
    module SimpleUnit
      module Constraints
        # The root of a simpleUnit document MUST be a `<unitList>`
        # declaring `convention="convention:simpleUnit"`. Any other
        # root shape is rejected.
        class RootMustBeUnitList < Chemicalml::Convention::Constraint::DocumentConstraint
          def check(document)
            return [] if document.is_a?(Chemicalml::Cml::Role::UnitList) &&
                         document.convention == 'convention:simpleUnit'

            [violation(path: '/',
                       message: 'simpleUnit root must be <unitList> declaring ' \
                                'convention="convention:simpleUnit"')]
          end
        end
      end
    end
  end
end
