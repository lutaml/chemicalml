# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # CompChem `array` value-container rules: MUST have `size`
        # attribute (≥ 1); `dataType` MUST be integer or double;
        # MUST have `units`.
        class ArrayRules < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'CompChem `array` value-container rules: MUST have `size` attribute (≥ 1); `dataType` MUST be integer or double; MUST have `units`.'
          applies_to Chemicalml::Cml::Role::Array
          include ModulePredicates

          ALLOWED_TYPES = %w[xsd:integer xsd:double].freeze

          def check_node(node, path)
            violations = []
            if node.size.to_s.empty? || node.size.to_i < 1
              violations << violation(path: path.join('/'),
                                      message: 'array must have a size attribute (minimum 1)')
            end
            unless ALLOWED_TYPES.include?(node.data_type.to_s)
              violations << violation(path: path.join('/'),
                                      message: 'array dataType must be xsd:integer or xsd:double ' \
                                               "(got #{node.data_type.inspect})")
            end
            if node.units.to_s.empty?
              violations << violation(path: path.join('/'),
                                      message: 'array must have units (even if dimensionless)')
            end
            violations
          end

          private

          def array?(node)
            node.is_a?(Chemicalml::Cml::Role::Array)
          end
        end
      end
    end
  end
end
