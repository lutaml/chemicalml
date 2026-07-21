# frozen_string_literal: true

require 'logger'

module Chemicalml
  # Logger used across the CLI and API. Wraps Ruby's ::Logger and can
  # bridge to Thor's `say` / `say_error` when running under a Thor
  # dispatcher — that gives coloured output on the terminal while
  # plain `Logger.new($stderr)` works for library callers.
  #
  # Severity routing under Thor:
  #   debug → suppressed (set level manually if needed)
  #   info  → say (green-ish, $stdout)
  #   warn  → say_error with :yellow ($stderr)
  #   error → say_error with :red   ($stderr)
  #   fatal → say_error with :red   ($stderr)
  class Logger < ::Logger
    attr_reader :thor_shell

    # Bridge to a Thor shell instance (self inside a Thor command).
    # When set, info/warn/error route through Thor for coloured output.
    def thor_shell=(shell)
      @thor_shell = shell
    end

    def add(severity, message = nil, progname = nil)
      return super unless thor_shell
      return true if severity < level

      msg = message || progname
      case severity
      when ERROR, FATAL
        thor_shell.say_error(msg.to_s, :red)
      when WARN
        thor_shell.say_error(msg.to_s, :yellow)
      else
        thor_shell.say(msg.to_s)
      end
    end

    # Convenience: create a default logger that writes to $stderr at
    # INFO level. Used when no logger is explicitly provided.
    def self.default
      new($stderr).tap { |l| l.level = INFO }
    end
  end
end
