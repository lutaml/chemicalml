# frozen_string_literal: true

module Chemicalml
  module Convention
    module Dictionary
      module Constraints
        # The `namespace` URI SHOULD end with `/` or `#` so terms can
        # be referenced by appending them to the URI. Warning level.
        class DictionaryNamespaceShouldEndWithSlashOrHash < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'The `namespace` URI SHOULD end with `/` or `#` so terms can be referenced by appending them to the URI. Warning level.'
          applies_to Chemicalml::Cml::Role::Dictionary
          def check_node(node, path)
            ns = node.namespace.to_s
            return [] if ns.empty?
            return [] if ns.end_with?('/', '#')

            [violation(path: path.join('/'),
                       message: "dictionary namespace #{ns.inspect} should end with / or # " \
                                'so terms can be referenced by appending',
                       severity: :warning)]
          end

          private

          def dictionary?(node)
            node.is_a?(Chemicalml::Cml::Role::Dictionary)
          end
        end
      end
    end
  end
end
