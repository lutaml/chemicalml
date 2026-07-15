# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        class ScalarMustHaveDataType < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Scalar
          def check_node(node, path)

            return [] unless node.data_type.to_s.empty?

            [violation(path: path.empty? ? 'scalar' : path.join('/'),
                       message: 'scalar must have a dataType attribute')]
          end
        end
      end
    end
  end
end
