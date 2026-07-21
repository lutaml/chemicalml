# frozen_string_literal: true

module Chemicalml
  module Cli
    # `chemicalml info <element>` — show details about a CML element
    # by XML name: Ruby class, role, attributes, applicable constraints.
    class InfoCommand < Command
      def run(options)
        name = options[:element]
        unless name
          stderr 'info requires an <element-name> argument (e.g. "atom")'
          return 2
        end

        klass = Chemicalml::Cml.for_xml_name(name)
        unless klass
          stderr "unknown element: #{name}"
          return 2
        end

        Chemicalml::Cml::Schema3::Configuration.ensure_registered!
        puts "Element: <#{name}>"
        puts "Class:   #{klass}"
        role = role_of(klass)
        puts "Role:    #{role || '(none)'}"
        puts ''
        puts "Attributes (#{klass.attributes.size}):"
        klass.attributes.each_value do |attr|
          col = attr.collection? ? '[]' : ' '
          puts "  #{attr.name}#{col}"
        end
        applicable = constraints_for_role(role)
        return 0 if applicable.empty?

        puts ''
        puts "Applicable constraints (#{applicable.size}):"
        applicable.each do |(conv, c)|
          puts "  [#{conv.qname}] #{c.name.split('::').last}"
        end
        0
      end

      private

      def role_of(klass)
        # Find the most specific Role module included in klass
        # (the one with the longest name that matches Cml::Role::*).
        klass.ancestors.find do |a|
          next false unless a.is_a?(Module)
          next false unless a.name

          a.name.start_with?('Chemicalml::Cml::Role::')
        end
      end

      def constraints_for_role(role)
        return [] unless role

        Chemicalml::Convention::Registry.each_constraint.with_object([]) do |(conv, c), acc|
          roles = c.applies_to_roles
          next if roles.nil?

          matched = roles.any? do |r|
            role <= r
          rescue StandardError
            false
          end
          next unless matched

          acc << [conv, c]
        end
      rescue StandardError
        []
      end
    end
  end
end
