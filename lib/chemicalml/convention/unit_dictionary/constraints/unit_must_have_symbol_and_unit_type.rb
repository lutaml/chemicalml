# frozen_string_literal: true

module Chemicalml
  module Convention
    module UnitDictionary
      module Constraints
        # Every unit MUST have `id`, `title`, `symbol`, `parentSI`,
        # at least one of `multiplierToSI`/`constantToSI`, and
        # `unitType` per the unit-dictionary convention.
        class UnitMustHaveSymbolAndUnitType < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'Every unit MUST have `id`, `title`, `symbol`, `parentSI`, at least one of `multiplierToSI`/`constantToSI`, and `unitType` per the unit-dictionary convention.'
          applies_to Chemicalml::Cml::Role::Unit
          REQUIRED = %i[title symbol parent_si unit_type].freeze

          def check_node(node, path)
            violations = []
            REQUIRED.each do |attr|
              val = node.public_send(attr)
              next unless val.to_s.empty?

              violations << violation(path: path.join('/'),
                                      message: "unit must have #{attr} (id=#{node.id.inspect})")
            end

            unless has_si_conversion?(node)
              violations << violation(path: path.join('/'),
                                      message: "unit must have multiplierToSI or constantToSI (id=#{node.id.inspect})")
            end

            violations
          end

          private

          def unit?(node)
            node.is_a?(Chemicalml::Cml::Role::Unit)
          end

          def has_si_conversion?(node)
            !node.multiplier_to_si.to_s.empty? || !node.constant_to_si.to_s.empty?
          end
        end
      end
    end
  end
end
