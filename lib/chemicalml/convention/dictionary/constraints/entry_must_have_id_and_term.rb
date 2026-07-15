# frozen_string_literal: true

module Chemicalml
  module Convention
    module Dictionary
      module Constraints
        # Every entry MUST have an `id` and a `term` attribute per the
        # dictionary convention.
        class EntryMustHaveIdAndTerm < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::DictionaryEntry
          def check_node(node, path)

            violations = []
            if node.id.to_s.empty?
              violations << violation(path: path.join('/'),
                                      message: 'entry must have an id attribute')
            end
            if node.term.to_s.empty?
              violations << violation(path: path.join('/'),
                                      message: 'entry must have a term attribute')
            end
            violations
          end

          private

          def entry?(node)
            node.is_a?(Chemicalml::Cml::Role::DictionaryEntry)
          end
        end
      end
    end
  end
end
