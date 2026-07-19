# frozen_string_literal: true

module Chemicalml
  module Convention
    module Cascade
      module Constraints
        autoload :ReactionSchemeMustHaveContent,
                 'chemicalml/convention/cascade/constraints/reaction_scheme_must_have_content'
        autoload :ReactionStepListMustContainSteps,
                 'chemicalml/convention/cascade/constraints/reaction_step_list_must_contain_steps'
        autoload :ReactionStepMustHaveReactionOrLists,
                 'chemicalml/convention/cascade/constraints/reaction_step_must_have_reaction_or_lists'
        autoload :ReactiveCentreAtomRefsShouldBePresent,
                 'chemicalml/convention/cascade/constraints/reactive_centre_atom_refs_should_be_present'
      end
    end
  end
end
