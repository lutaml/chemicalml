# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        class AtomIdMustMatchPattern < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Atom
          ID_PATTERN = /\A[A-Za-z][A-Za-z0-9._-]*\z/

          def check_node(node, path)

            id = node.id.to_s
            return [] if id.empty?
            return [] if id.match?(ID_PATTERN)

            [violation(path: path.empty? ? 'atom' : path.join('/'),
                       message: "atom id #{id.inspect} must start with a letter and " \
                                'contain only letters, digits, dot, hyphen, or underscore',
                       severity: :warning,
                       value: id)]
          end
        end
      end
    end
  end
end
