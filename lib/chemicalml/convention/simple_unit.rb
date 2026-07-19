# frozen_string_literal: true

module Chemicalml
  module Convention
    # The simpleUnit convention — the worked example from the CMLLite
    # paper. A toy convention demonstrating the convention framework.
    #
    # Namespace: http://www.xml-cml.org/convention/simpleUnit
    #
    # Constraints:
    #
    # - the root MUST be a `<unitList>` declaring
    #   `convention="convention:simpleUnit"`
    # - each `<unit>` MUST have a `power` attribute (integer)
    # - each `<unit>` MUST have a non-empty `symbol` attribute
    module SimpleUnit
      extend Base

      autoload :Constraints, 'chemicalml/convention/simple_unit/constraints'

      QNAME = 'convention:simpleUnit'
      NAMESPACE_URI = "#{Chemicalml::Convention::CONVENTION_NAMESPACE}simpleUnit".freeze

      def self.qname
        QNAME
      end

      def self.namespace_uri
        NAMESPACE_URI
      end

      register Constraints::UnitMustHavePower
      register Constraints::UnitMustHaveSymbol
      register Constraints::RootMustBeUnitList
    end
  end
end
