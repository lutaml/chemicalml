# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # An `initialization` module MUST contain at least one of:
        # `molecule`, `parameterList`, or a user-defined module child.
        # Per the compchem convention spec.
        class InitializationMustHaveContent < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Module

          def check_node(node, path)
            return [] unless node.dict_ref == 'compchem:initialization'

            has_molecule = molecule_count(node).positive?
            has_param_list = parameter_list_count(node).positive?
            has_user_module = user_module_count(node).positive?
            return [] if has_molecule || has_param_list || has_user_module

            [violation(path: path.join('/'),
                       message: 'initialization module must contain at least one of: ' \
                                'molecule, parameterList, or user-defined module')]
          end

          private

          def molecule_count(node)
            (node.molecules || []).size
          end

          def parameter_list_count(node)
            (node.parameter_lists || []).size
          end

          # User-defined modules: any module child whose dict_ref is
          # not one of the compchem-defined roles.
          COMPCHEM_ROLES = %w[
            compchem:jobList compchem:job compchem:initialization
            compchem:calculation compchem:finalization compchem:environment
          ].freeze

          def user_module_count(node)
            (node.modules || []).count do |m|
              dr = m.dict_ref.to_s
              !dr.empty? && !COMPCHEM_ROLES.include?(dr)
            end
          end
        end
      end
    end
  end
end
