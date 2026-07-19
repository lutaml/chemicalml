# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # A `<bond>`'s `id` attribute SHOULD match the XSD idType
        # pattern (letter start, alphanumeric body with dots/dashes).
        # Warning severity.
        class BondIdShouldMatchPattern < Chemicalml::Convention::Constraint::NodeConstraint
          include Chemicalml::Cml::Patterns

          applies_to Chemicalml::Cml::Role::Bond

          def check_node(node, _path)
            id = node.id.to_s
            return [] if id.empty?
            return [] if id.match?(/\A#{ID_PATTERN.source}\z/)

            [violation(path: yield_path(node),
                       message: "bond id #{id.inspect} should match the idType pattern " \
                                '(letter start, alphanumeric body with . and -)',
                       severity: :warning,
                       value: id)]
          end

          private

          def yield_path(node)
            id = node.node_id
            id ? "bond[#{id}]" : 'bond'
          end
        end
      end
    end
  end
end
