# frozen_string_literal: true

module Chemicalml
  module Convention
    module Dictionary
      module Constraints
        # An `<entry>` MUST contain a single `definition` child
        # element. The schema allows it as a string; this constraint
        # enforces presence.
        class EntryMustContainDefinition < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'An `<entry>` MUST contain a single `definition` child element. The schema allows it as a string; this constraint enforces presence.'
          applies_to Chemicalml::Cml::Role::DictionaryEntry
          def check_node(node, path)
            return [] unless node.definition.to_s.strip.empty?

            [violation(path: path.join('/'),
                       message: "entry #{node.id.inspect} must contain a single definition child")]
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
