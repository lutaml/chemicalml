# frozen_string_literal: true

require 'yaml'

module Chemicalml
  module Dictionary
    # Reads a YAML file conforming to the dictionary schema (see
    # `TODO.cml-full/05-dictionary-layer.md`) and constructs a
    # `Chemicalml::Dictionary::Model`.
    #
    # This is the *only* place that knows about the YAML wire shape —
    # everything else works in terms of the canonical Model.
    module Loader
      def self.from_file(path)
        from_hash(YAML.load_file(path))
      end

      def self.from_hash(hash)
        Model.new(
          namespace: hash.fetch('namespace'),
          prefix: hash.fetch('prefix'),
          title: hash.fetch('title'),
          description: hash['description'],
          entries: (hash['entries'] || []).map { |e| build_entry(e) }
        )
      end

      def self.build_entry(h)
        Entry.new(
          id: h.fetch('id'),
          term: h.fetch('term'),
          definition: h.fetch('definition'),
          description: h['description'],
          data_type: h['data_type'],
          unit_type: h['unit_type'],
          units: h['units'],
          enum: build_enum(h['enum']),
          links: (h['links'] || []).map { |l| build_link(l) },
          source_code: h['source_code']
        )
      end
      private_class_method :build_entry

      def self.build_enum(h)
        return nil unless h

        Enum.new(
          kind: h['kind'] || :open,
          values: h['values'] || []
        )
      end
      private_class_method :build_enum

      def self.build_link(h)
        Link.new(rel: h.fetch('rel'), href: h.fetch('href'), title: h['title'])
      end
      private_class_method :build_link
    end
  end
end
