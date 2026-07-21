# frozen_string_literal: true

module Chemicalml
  module Cli
    # Base class for every command. Subclasses implement `#run(options)`.
    #
    # The `options` hash carries both positional args and flags
    # (Thor parses both, the dispatcher merges them). This matches the
    # requested invocation pattern:
    #
    #   MyCommandClass.new.run(options)
    class Command
      class << self
        def run(options = {})
          new.run(options)
        end
      end

      def run(_options = {})
        raise NotImplementedError, "#{self.class} must implement #run"
      end

      private

      def puts(*)
        $stdout.puts(*)
      end

      def stderr(*)
        warn(*)
      end
    end
  end
end
