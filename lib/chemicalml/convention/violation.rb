# frozen_string_literal: true

module Chemicalml
  module Convention
    # Value object describing one constraint violation. Severity is
    # either `:error` (document is invalid under the convention) or
    # `:warning` (document is valid but problematic).
    #
    # `value` carries the offending value where natural (e.g. the
    # duplicated atom id, the malformed unit symbol). Optional —
    # constraints that flag a missing attribute leave `value` nil.
    class Violation
      SEVERITIES = %i[error warning].freeze

      attr_reader :path, :message, :severity, :constraint, :value

      def initialize(path:, message:, severity: :error, constraint: nil, value: nil)
        raise ArgumentError, "unknown severity: #{severity.inspect}" unless SEVERITIES.include?(severity.to_sym)

        @path       = path
        @message    = message
        @severity   = severity.to_sym
        @constraint = constraint
        @value      = value
        freeze
      end

      def error?
        severity == :error
      end

      def warning?
        severity == :warning
      end

      def to_s
        suffix = value.nil? ? '' : " (value=#{value.inspect})"
        "#{severity.upcase} #{path}: #{message}#{suffix}"
      end
    end
  end
end
