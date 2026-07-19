# frozen_string_literal: true

module Chemicalml
  module Cli
    # Base class for every command. Subclasses implement `#run(options)`.
    #
    # The `options` hash carries both positional arguments and flags
    # (Thor parses both, the dispatcher merges them). This matches the
    # requested invocation pattern:
    #
    #   MyCommandClass.new.run(options)
    #
    # Adding a new command:
    #   1. Subclass `Chemicalml::Cli::Command`
    #   2. Implement `#run(options)` returning an exit code
    #   3. Add a `desc + def` block in `Chemicalml::Cli::Base` that
    #      calls `MyCommand.new.run(hash)`
    class Command
      class << self
        # Convenience: dispatch to a fresh instance. Equivalent to
        # `new.run(options)`.
        def run(options = {})
          new.run(options)
        end
      end

      # Subclasses MUST override.
      # @param options [Hash{Symbol=>Object}] both positional args and
      #   flags, keyed by symbol. Positional args use declared keys
      #   (e.g. `:file`, `:element`); flags use their long-option name.
      # @return [Integer] exit code (0 success, 1 warn, 2 usage error).
      def run(_options = {})
        raise NotImplementedError, "#{self.class} must implement #run"
      end

      private

      def puts(*args)
        $stdout.puts(*args)
      end

      def warn(*args)
        $stderr.puts(*args)
      end
    end
  end
end
