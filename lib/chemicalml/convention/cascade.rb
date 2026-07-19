# frozen_string_literal: true

module Chemicalml
  module Convention
    # The Cascade convention. A chemicalml-specific convention for CML
    # reaction cascades — multi-step reaction networks encoded via
    # `<reactionScheme>`, `<reactionStepList>`, `<reactionStep>`,
    # `<reaction>`, and `<reactiveCentre>`.
    #
    # Upstream CML does not publish a dedicated cascade convention; the
    # wire elements exist in the XSD but no constraints guard their
    # well-formedness. This convention covers the gaps:
    #
    # - reactionScheme MUST contain at least one reactionStepList or
    #   reaction (an empty scheme carries no cascade)
    # - reactionStepList MUST contain at least one reactionStep
    # - reactionStep MUST contain a reaction or explicit reactant/product
    #   lists (an empty step is a dead-end in the cascade)
    # - reactiveCentre atomRefs SHOULD be parseable atom references
    #   (warning — gracefully degrades when context is missing)
    module Cascade
      extend Base

      autoload :Constraints, 'chemicalml/convention/cascade/constraints'

      QNAME = 'convention:cascade'
      NAMESPACE_URI = "#{Chemicalml::Convention::CONVENTION_NAMESPACE}cascade".freeze

      def self.qname
        QNAME
      end

      def self.namespace_uri
        NAMESPACE_URI
      end

      register Constraints::ReactionSchemeMustHaveContent
      register Constraints::ReactionStepListMustContainSteps
      register Constraints::ReactionStepMustHaveReactionOrLists
      register Constraints::ReactiveCentreAtomRefsShouldBePresent
    end
  end
end
