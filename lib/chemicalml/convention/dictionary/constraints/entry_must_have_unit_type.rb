# frozen_string_literal: true

module Chemicalml
  module Convention
    module Dictionary
      module Constraints
        # An `<entry>` MUST have a `unitType` attribute. Entries
        # describing concepts that should not have units (e.g. name
        # of a program) should reference `none` in the standard CML
        # unitType dictionary.
        class EntryMustHaveUnitType < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::DictionaryEntry
          def check_node(node, path)
            return [] unless node.unit_type.to_s.empty?

            [violation(path: path.join('/'),
                       message: "entry #{node.id.inspect} must have a unitType attribute " \
                                "(use 'none' for concepts without units)")]
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
