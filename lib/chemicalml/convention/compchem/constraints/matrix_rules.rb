# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # CompChem `matrix` value-container rules: MUST have `rows`
        # and `columns` attributes (each ≥ 1); `dataType` MUST be
        # integer or double; MUST have `units`.
        class MatrixRules < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'CompChem `matrix` value-container rules: MUST have `rows` and `columns` attributes (each ≥ 1); `dataType` MUST be integer or double; MUST have `units`.'
          applies_to Chemicalml::Cml::Role::Matrix
          include ModulePredicates

          ALLOWED_TYPES = %w[xsd:integer xsd:double].freeze

          def check_node(node, path)
            violations = []
            if node.rows.to_s.empty? || node.rows.to_i < 1
              violations << violation(path: path.join('/'),
                                      message: 'matrix must have a rows attribute (minimum 1)')
            end
            if node.columns.to_s.empty? || node.columns.to_i < 1
              violations << violation(path: path.join('/'),
                                      message: 'matrix must have a columns attribute (minimum 1)')
            end
            unless ALLOWED_TYPES.include?(node.data_type.to_s)
              violations << violation(path: path.join('/'),
                                      message: 'matrix dataType must be xsd:integer or xsd:double ' \
                                               "(got #{node.data_type.inspect})")
            end
            if node.units.to_s.empty?
              violations << violation(path: path.join('/'),
                                      message: 'matrix must have units (even if dimensionless)')
            end
            violations
          end

          private

          def matrix?(node)
            node.is_a?(Chemicalml::Cml::Role::Matrix)
          end
        end
      end
    end
  end
end
