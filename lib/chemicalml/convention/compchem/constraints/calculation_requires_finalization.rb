# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # Co-constraint: if a calculation module is present inside a
        # job, a finalization MUST also be present.
        class CalculationRequiresFinalization < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'Co-constraint: if a calculation module is present inside a job, a finalization MUST also be present.'
          applies_to Chemicalml::Cml::Role::Module
          include ModulePredicates

          def check_node(node, path)
            calculations = child_modules_with(node, 'compchem:calculation')
            finalizations = child_modules_with(node, 'compchem:finalization')
            return [] if calculations.empty?
            return [] unless finalizations.empty?

            [violation(path: path.join('/'),
                       message: 'job module has a calculation but no finalization ' \
                                '(finalization MUST be present when calculation is)')]
          end
        end
      end
    end
  end
end
