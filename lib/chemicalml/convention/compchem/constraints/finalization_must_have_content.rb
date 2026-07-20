# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # A `finalization` module MUST contain at least one of:
        # `molecule`, `propertyList`, or a user-defined module child.
        # Per the compchem convention spec.
        class FinalizationMustHaveContent < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'A `finalization` module MUST contain at least one of: `molecule`, `propertyList`, or a user-defined module child. Per the compchem convention spec.'
          applies_to Chemicalml::Cml::Role::Module

          def check_node(node, path)
            return [] unless node.dict_ref == 'compchem:finalization'

            has_molecule = (node.molecules || []).any?
            has_prop_list = (node.property_lists || []).any?
            has_user_module = user_module_count(node).positive?
            return [] if has_molecule || has_prop_list || has_user_module

            [violation(path: path.join('/'),
                       message: 'finalization module must contain at least one of: ' \
                                'molecule, propertyList, or user-defined module')]
          end

          private

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
