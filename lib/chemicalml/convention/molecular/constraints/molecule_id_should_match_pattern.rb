# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # A `<molecule>`'s `id` attribute SHOULD match the XSD
        # moleculeIDType pattern (letter/underscore start, alphanumeric
        # body, optional namespace prefix). Warning severity.
        class MoleculeIdShouldMatchPattern < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = "A `<molecule>`'s `id` attribute SHOULD match the XSD moleculeIDType pattern (letter/underscore start, alphanumeric body, optional namespace prefix). Warning severity."
          include Chemicalml::Cml::Patterns

          applies_to Chemicalml::Cml::Role::Molecule

          def check_node(node, _path)
            id = node.id.to_s
            return [] if id.empty?
            return [] if id.match?(/\A#{MOLECULE_ID_PATTERN.source}\z/)

            [violation(path: yield_path(node),
                       message: "molecule id #{id.inspect} should match the moleculeIDType pattern " \
                                '(letter start, alphanumeric body, optional prefix)',
                       severity: :warning,
                       value: id)]
          end

          private

          def yield_path(node)
            id = node.node_id
            id ? "molecule[#{id}]" : 'molecule'
          end
        end
      end
    end
  end
end
