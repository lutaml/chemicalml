# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        class PropertyMustHaveDictRef < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Property
          def check_node(node, path)

            return [] unless node.dict_ref.to_s.empty?

            [violation(path: path.empty? ? 'property' : path.join('/'),
                       message: 'property must have a dictRef attribute')]
          end
        end
      end
    end
  end
end
