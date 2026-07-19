# frozen_string_literal: true

module Chemicalml
  module Cli
    # `chemicalml constraints` — list every registered constraint
    # across every convention with its applies_to roles.
    class ConstraintsCommand < Command
      def run(_options = {})
        current = nil
        Chemicalml::Convention::Registry.each_constraint do |conv, klass|
          unless conv.qname == current
            current = conv.qname
            puts ''
            puts "=== #{current} (#{conv.constraint_count}) ==="
          end
          name = klass.name.split('::').last
          applies = klass.applies_to_roles
          roles_str = applies.nil? ? '' : "  → #{applies.map { |r| r.name.split('::').last }.join(', ')}"
          puts "  #{name}#{roles_str}"
          desc = klass.description
          puts "    #{desc}" unless desc == name
        end
        0
      end
    end
  end
end
