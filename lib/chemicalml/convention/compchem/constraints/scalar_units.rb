# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # CompChem value-container rules: `scalar` with dataType
        # `xsd:integer` or `xsd:double` MUST have `units`; `scalar`
        # with dataType `xsd:string` MUST NOT have `units`.
        class ScalarUnits < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Scalar
          include ModulePredicates

          NUMERIC_TYPES = %w[xsd:integer xsd:double].freeze

          def check_node(node, path)

            data_type = node.data_type.to_s
            units = node.units.to_s
            violations = []

            if NUMERIC_TYPES.include?(data_type) && units.empty?
              violations << violation(path: path.join('/'),
                                      message: "scalar with dataType #{data_type.inspect} must have units")
            end
            if data_type == 'xsd:string' && !units.empty?
              violations << violation(path: path.join('/'),
                                      message: "scalar with dataType 'xsd:string' must not have units")
            end
            violations
          end

          private

          def scalar?(node)
            node.is_a?(Chemicalml::Cml::Role::Scalar)
          end
        end
      end
    end
  end
end
