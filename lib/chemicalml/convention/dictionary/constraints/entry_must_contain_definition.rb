# frozen_string_literal: true

module Chemicalml
  module Convention
    module Dictionary
      module Constraints
        # An `<entry>` MUST contain a single `definition` child
        # element. The schema allows it as a string; this constraint
        # enforces presence.
        class EntryMustContainDefinition < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'An `<entry>` MUST contain a single `definition` child element. '
          applies_to Chemicalml::Cml::Role::DictionaryEntry
          def check_node(node, path)
            definition = node.definition
            return [] if definition_contained?(definition)

            [violation(path: path.join('/'),
                       message: "entry #{node.id.inspect} must contain a single definition child")]
          end

          private

          # CML allows the definition content as plain text or as
          # rich text (<xhtml:p> paragraphs); the wire class types it
          # structured, but a plain string remains valid at
          # construction.
          def definition_contained?(definition)
            return false if definition.nil?
            return !definition.to_s.strip.empty? if definition.is_a?(String)

            !(definition.content.to_s.strip.empty? &&
              Array(definition.paragraphs).empty?)
          end

          def entry?(node)
            node.is_a?(Chemicalml::Cml::Role::DictionaryEntry)
          end
        end
      end
    end
  end
end
