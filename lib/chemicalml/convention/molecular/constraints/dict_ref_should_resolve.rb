# frozen_string_literal: true

module Chemicalml
  module Convention
    module Molecular
      module Constraints
        # Walks the document and warns on any element whose `dictRef`
        # attribute cannot be resolved against the built-in
        # dictionaries. Catches typos like `dictRef="cml:bpingpoint"`.
        #
        # DocumentConstraint — needs the whole tree, but the resolver
        # works per-node so it's just a wrapper around the per-node
        # check.
        class DictRefShouldResolve < Chemicalml::Convention::Constraint::NodeConstraint
          self.description = 'Walks the document and warns on any element whose `dictRef` attribute cannot be resolved against the built-in dictionaries. Catches typos like `dictRef="cml:bpingpoint"`.'
          applies_to Chemicalml::Cml::Role::Atom,
                     Chemicalml::Cml::Role::Bond,
                     Chemicalml::Cml::Role::Molecule,
                     Chemicalml::Cml::Role::Property,
                     Chemicalml::Cml::Role::Scalar,
                     Chemicalml::Cml::Role::Array,
                     Chemicalml::Cml::Role::Matrix,
                     Chemicalml::Cml::Role::Name,
                     Chemicalml::Cml::Role::Label

          def check_node(node, path)
            dict_ref = node.dict_ref.to_s.strip
            return [] if dict_ref.empty?
            return [] if resolves?(dict_ref)

            [violation(path: path_fingerprint(node, path),
                       message: "#{node.element_name} #{node_id_or_blank(node).inspect} " \
                                "dictRef #{dict_ref.inspect} does not resolve against any built-in dictionary",
                       severity: :warning,
                       value: dict_ref)]
          end

          private

          def resolves?(dict_ref)
            !Chemicalml::Dictionary::Registry.lookup(dict_ref).nil?
          rescue StandardError
            false
          end

          def path_fingerprint(node, path)
            base = path.empty? ? node.element_name : path.join('/')
            id = node.node_id
            id ? "#{base}[#{id}]" : base
          end

          def node_id_or_blank(node)
            node.node_id || ''
          end
        end
      end
    end
  end
end
