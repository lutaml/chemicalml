# frozen_string_literal: true

module Chemicalml
  module Convention
    module Compchem
      module Constraints
        # The initialization module MUST NOT contain more than one
        # molecule child.
        class InitializationAtMostOneMolecule < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Module
          include ModulePredicates

          def check_node(node, path)

            molecules = node.molecules || []
            return [] if molecules.length <= 1

            [violation(path: path.join('/'),
                       message: 'initialization module must not contain more than ' \
                                "one molecule (found #{molecules.length})")]
          end
        end
      end
    end
  end
end
