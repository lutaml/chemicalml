# frozen_string_literal: true

module Chemicalml
  module Dictionary
    # An entry's enum constraint. CML dictionary entries can be tagged
    # as either an *open* set (the listed values are recommended but
    # others are allowed) or a *closed* set (only the listed values are
    # valid).
    class Enum
      KINDS = %i[open closed].freeze

      attr_reader :kind, :values

      def initialize(kind: :open, values: [])
        raise ArgumentError, "unknown enum kind: #{kind.inspect}" unless KINDS.include?(kind.to_sym)

        @kind = kind.to_sym
        @values = values.to_a
        freeze
      end

      def open?
        kind == :open
      end

      def closed?
        kind == :closed
      end

      def allows?(value)
        return true if open?
        return true if values.empty?

        values.include?(value)
      end

      def to_h
        { kind: kind, values: values }
      end

      def eql?(other)
        other.is_a?(Enum) && kind == other.kind && values == other.values
      end
      alias == eql?

      def hash
        [kind, values].hash
      end
    end
  end
end
