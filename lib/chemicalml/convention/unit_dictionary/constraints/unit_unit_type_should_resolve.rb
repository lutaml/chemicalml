# frozen_string_literal: true

module Chemicalml
  module Convention
    module UnitDictionary
      module Constraints
        # A `<unit>`'s `unitType` attribute SHOULD reference a unitType
        # that exists in a built-in unitType-dictionary. Catches typos
        # like `unitType="unitType:lenght"` (misspelled).
        #
        # The lookup uses the dictionary registry, which inspects every
        # built-in dictionary. Cross-component check parallel to
        # DictRefShouldResolve in the molecular convention.
        class UnitUnitTypeShouldResolve < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Unit

          def check_node(node, _path)
            unit_type = node.unit_type.to_s.strip
            return [] if unit_type.empty?
            return [] if resolves?(unit_type)

            [violation(path: yield_path(node),
                       message: "unit #{node.id.inspect} unitType #{unit_type.inspect} does not " \
                                'resolve against any built-in unitType-dictionary',
                       severity: :warning,
                       value: unit_type)]
          end

          private

          def resolves?(unit_type)
            !Chemicalml::Dictionary::Registry.lookup(unit_type).nil?
          rescue StandardError
            false
          end

          def yield_path(node)
            id = node.node_id
            id ? "unit[#{id}]" : 'unit'
          end
        end
      end
    end
  end
end
