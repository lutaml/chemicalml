# frozen_string_literal: true

module Chemicalml
  module Convention
    module Dictionary
      module Constraints
        # An `<entry>` `id` MUST match `[A-Za-z][A-Za-z0-9._-]*` —
        # start with a letter, followed by letters/digits/dot/hyphen/
        # underscore. Mirrors the upstream IdStartChar / IdChar BNF.
        class EntryIdMustMatchPattern < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'An `<entry>` `id` MUST match `[A-Za-z][A-Za-z0-9._-]*` — start with a letter, followed by letters/digits/dot/hyphen/ underscore. Mirrors the upstream IdStartChar / IdChar BNF.'
          applies_to Chemicalml::Cml::Role::DictionaryEntry
          PATTERN = /\A[A-Za-z][A-Za-z0-9._-]*\z/

          def check_node(node, path)
            id = node.id.to_s
            return [] if id.empty?
            return [] if id.match?(PATTERN)

            [violation(path: path.join('/'),
                       message: "entry id #{id.inspect} must match [A-Za-z][A-Za-z0-9._-]*")]
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
