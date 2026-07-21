# frozen_string_literal: true

module Chemicalml
  module Schema
    # Value object describing one CML schema version. Immutable.
    class Definition
      attr_reader :version, :xsd_path, :xml_namespace, :ruby_namespace

      def initialize(version:, xsd_path:, xml_namespace:, ruby_namespace:)
        @version = version
        @xsd_path = xsd_path
        @xml_namespace = xml_namespace
        @ruby_namespace = ruby_namespace
        freeze
      end

      def xsd_full_path
        File.expand_path(xsd_path, project_root)
      end

      def wire_namespace_constant
        ruby_namespace.split('::').reduce(Object) { |ns, name| ns.const_get(name) }
      end

      def eql?(other)
        other.is_a?(Definition) && version == other.version
      end
      alias == eql?

      def hash
        version.hash
      end

      private

      def project_root
        File.expand_path('../../..', __dir__)
      end
    end
  end
end
