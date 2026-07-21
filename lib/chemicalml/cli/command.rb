# frozen_string_literal: true

module Chemicalml
  module Cli
    # Base class for every command. Subclasses implement `#run(options)`.
    #
    # Each command receives a `Chemicalml::Logger` in its constructor.
    # When dispatched via Thor (the normal CLI path), the logger is
    # bridged to Thor's shell for coloured output. When invoked
    # directly (MyCommand.new.run(options)), the logger writes plain
    # text to $stderr.
    class Command
      attr_reader :logger

      # @param logger [Chemicalml::Logger] the logger to use. Defaults
      #   to a plain stderr logger. The Thor dispatcher passes one
      #   bridged to Thor's shell for colour.
      def initialize(logger: Chemicalml::Logger.default)
        @logger = logger
      end

      class << self
        def run(options = {}, logger: Chemicalml::Logger.default)
          new(logger: logger).run(options)
        end
      end

      def run(_options = {})
        raise NotImplementedError, "#{self.class} must implement #run"
      end

      private

      def puts(*args)
        $stdout.puts(*args)
      end

      def stderr(*args)
        $stderr.puts(*args)
      end
    end
  end
end
