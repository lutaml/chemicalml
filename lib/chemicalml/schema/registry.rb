# frozen_string_literal: true

module Chemicalml
  module Schema
    # Lookup table for schema versions. Adding a new schema = adding
    # one entry to `Chemicalml::Schema::BUILTIN`. No mutation of
    # existing entries, no switch statements.
    module Registry
      LOOKUP = Schema::BUILTIN.each_with_object({}) do |(key, defn), h|
        h[key] = defn
        h[key.to_s] = defn
      end.freeze

      def self.lookup(name)
        entry = LOOKUP[name] || LOOKUP[name.to_sym] || LOOKUP[name.to_s]
        raise ArgumentError, "unknown schema version: #{name.inspect}" unless entry

        entry
      end

      def self.versions
        Schema::BUILTIN.keys.freeze
      end

      def self.default
        lookup(:schema3)
      end
    end
  end
end
