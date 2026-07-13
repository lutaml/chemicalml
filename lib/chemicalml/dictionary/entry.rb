# frozen_string_literal: true

module Chemicalml
  module Dictionary
    # One dictionary entry. Plain Ruby value object — format-agnostic.
    # The YAML shape mirrors the structure documented in
    # `TODO.cml-full/05-dictionary-layer.md`.
    class Entry
      ID_PATTERN = /\A[A-Za-z][A-Za-z0-9._-]*\z/.freeze

      attr_reader :id, :term, :definition, :description,
                  :data_type, :unit_type, :units,
                  :enum, :links, :source_code

      def initialize(id:, term:, definition:, description: nil,
                     data_type: nil, unit_type: nil, units: nil,
                     enum: nil, links: [], source_code: nil)
        raise ArgumentError, "invalid entry id: #{id.inspect}" unless id.to_s.match?(ID_PATTERN)

        @id          = id.to_s
        @term        = term
        @definition  = definition
        @description = description
        @data_type   = data_type
        @unit_type   = unit_type
        @units       = units
        @enum        = enum
        @links       = links.to_a
        @source_code = source_code
        freeze
      end

      def to_h
        h = {
          id: id,
          term: term,
          definition: definition
        }
        h[:description] = description if description
        h[:data_type]   = data_type   if data_type
        h[:unit_type]   = unit_type   if unit_type
        h[:units]       = units       if units
        h[:enum]        = enum.to_h   if enum
        h[:links]       = links.map(&:to_h) unless links.empty?
        h[:source_code] = source_code if source_code
        h
      end

      def eql?(other)
        other.is_a?(Entry) && id == other.id && to_h == other.to_h
      end
      alias == eql?

      def hash
        [id, to_h].hash
      end
    end
  end
end
