# frozen_string_literal: true

module Chemicalml
  module Convention
    module UnitDictionary
      module Constraints
        # A `<unit>`'s `parentSI` attribute SHOULD reference a unit
        # that exists in a built-in dictionary (typically the SI
        # dictionary). Catches typos like `parentSI="si:metr"`.
        #
        # Cross-component check parallel to UnitUnitTypeShouldResolve
        # and the molecular convention's DictRefShouldResolve.
        class UnitParentSiShouldResolve < Chemicalml::Convention::Constraint::NodeConstraint
          applies_to Chemicalml::Cml::Role::Unit

          def check_node(node, _path)
            parent_si = node.parent_si.to_s.strip
            return [] if parent_si.empty?
            return [] if resolves?(parent_si)

            [violation(path: yield_path(node),
                       message: "unit #{node.id.inspect} parentSI #{parent_si.inspect} does not " \
                                'resolve against any built-in unit dictionary',
                       severity: :warning,
                       value: parent_si)]
          end

          private

          def resolves?(parent_si)
            !Chemicalml::Dictionary::Registry.lookup(parent_si).nil?
          rescue StandardError
            false
          end

          def yield_path(node)
            id = node.node_id
            id ? "unit[#{id}]" : 'unit'
          end
        end
      end
    end
  end
end
