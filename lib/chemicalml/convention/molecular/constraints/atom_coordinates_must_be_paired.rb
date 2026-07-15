# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        class AtomCoordinatesMustBePaired < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Atom
          def check_node(node, path)

            violations = []
            has_x2 = !node.x2.to_s.empty?
            has_y2 = !node.y2.to_s.empty?
            if has_x2 != has_y2
              violations << violation(path: path.empty? ? 'atom' : path.join('/'),
                                      message: 'x2 and y2 must both be present or both absent')
            end

            has_x3 = !node.x3.to_s.empty?
            has_y3 = !node.y3.to_s.empty?
            has_z3 = !node.z3.to_s.empty?
            if [has_x3, has_y3, has_z3].any? && ![has_x3, has_y3, has_z3].all?
              violations << violation(path: path.empty? ? 'atom' : path.join('/'),
                                      message: 'x3, y3, and z3 must all be present together')
            end
            violations
          end
        end
      end
    end
  end
end
