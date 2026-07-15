# frozen_string_literal: true

module Chemicalml
  module Dictionary
    # The canonical dictionary model: namespace, prefix, title,
    # description, and an ordered collection of `Entry` instances.
    #
    # Plain Ruby — no XML, no YAML. Loading from YAML goes through
    # `Loader`; the wire (XML) shape is `Chemicalml::Cml::Dictionary`.
    class Model
      attr_reader :namespace, :prefix, :title, :description, :entries

      def initialize(namespace:, prefix:, title:, description: nil, entries: [])
        @namespace   = namespace
        @prefix      = prefix
        @title       = title
        @description = description
        @entries     = entries.to_a
        freeze
      end

      def lookup(qualified_name)
        _, id = split_qname(qualified_name)
        return nil unless id

        entries.find { |e| e.id == id }
      end

      def lookup!(qualified_name)
        lookup(qualified_name) ||
          raise(KeyError, "no entry #{qualified_name.inspect} in #{namespace}")
      end

      def entry_ids
        entries.map(&:id)
      end

      def value_attributes
        {
          namespace: namespace,
          prefix: prefix,
          title: title,
          description: description,
          entries: entries.map(&:value_attributes)
        }
      end

      def eql?(other)
        other.is_a?(Model) && namespace == other.namespace && value_attributes == other.value_attributes
      end
      alias == eql?

      def hash
        [namespace, value_attributes].hash
      end

      private

      def split_qname(qname)
        qname.to_s.split(':', 2)
      end
    end
  end
end
