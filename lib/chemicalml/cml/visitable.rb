# frozen_string_literal: true

module Chemicalml
  module Cml
    # Marker mixin included by every wire class. Provides a uniform
    # interface the convention-constraint walker relies on:
    #
    #   - `wire_children` returns the child wire nodes
    #   - `node_id` returns the id attribute or `nil`
    #   - `element_name` returns the XML tag name
    #
    # All three use lutaml-model's attribute registry — no duck typing.
    # A wire class that doesn't declare an `:id` attribute simply has
    # `node_id` return `nil`.
    module Visitable
      def wire_children
        declared_attribute_names.flat_map do |name|
          collect_wire_nodes(public_send(name))
        end
      end

      def node_id
        return id if declared_attribute?(:id)

        nil
      end

      def element_name
        xml_mapping = self.class.mappings[:xml]
        root = xml_mapping && xml_mapping.root
        root && root.name || self.class.name.split("::").last
      rescue StandardError
        self.class.name.split("::").last
      end

      def collect_wire_nodes(value)
        return [] if value.nil?

        if value.is_a?(::Array)
          value.select { |v| wire_node?(v) }
        elsif wire_node?(value)
          [value]
        else
          []
        end
      end

      def wire_node?(value)
        value.is_a?(Lutaml::Model::Serializable)
      end

      def declared_attribute_names
        self.class.model.attributes.keys
      rescue StandardError
        []
      end

      def declared_attribute?(name)
        self.class.model.attributes.key?(name)
      rescue StandardError
        false
      end
    end
  end
end
