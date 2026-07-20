# frozen_string_literal: true

module Chemicalml
  module Convention
    module Dictionary
      module Constraints
        # A `<dictionary>` element MUST have a `namespace` attribute
        # whose value is a valid URI defining the scope within which
        # the entry terms are unique.
        class DictionaryMustHaveNamespace < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'A `<dictionary>` element MUST have a `namespace` attribute whose value is a valid URI defining the scope within which the entry terms are unique.'
          applies_to Chemicalml::Cml::Role::Dictionary
          def check_node(node, path)
            return [] unless node.namespace.to_s.empty?

            [violation(path: path.join('/'),
                       message: 'dictionary must have a namespace attribute')]
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
