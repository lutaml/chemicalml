# frozen_string_literal: true

module Chemicalml
  module Convention
    # Value object describing one constraint violation. Severity is
    # either `:error` (document is invalid under the convention) or
    # `:warning` (document is valid but problematic).
    class Violation
      SEVERITIES = %i[error warning].freeze

      attr_reader :path, :message, :severity, :constraint

      def initialize(path:, message:, severity: :error, constraint: nil)
        raise ArgumentError, "unknown severity: #{severity.inspect}" unless SEVERITIES.include?(severity.to_sym)

        @path       = path
        @message    = message
        @severity   = severity.to_sym
        @constraint = constraint
        freeze
      end

      def error?
        severity == :error
      end

      def warning?
        severity == :warning
      end

      def to_s
        "#{severity.upcase} #{path}: #{message}"
      end
    end
  end
end
