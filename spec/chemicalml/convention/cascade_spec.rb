# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'cascade convention constraints' do
  let(:scheme_class)  { Chemicalml::Cml::Schema3::ReactionScheme }
  let(:list_class)    { Chemicalml::Cml::Schema3::ReactionStepList }
  let(:step_class)    { Chemicalml::Cml::Schema3::ReactionStep }
  let(:reaction_class) { Chemicalml::Cml::Schema3::Reaction }
  let(:reactant_list_class) { Chemicalml::Cml::Schema3::ReactantList }
  let(:product_list_class)  { Chemicalml::Cml::Schema3::ProductList }
  let(:reactive_centre_class) { Chemicalml::Cml::Schema3::ReactiveCentre }

  def validate(node)
    Chemicalml::Convention::Cascade.validate(node)
  end

  describe 'registration' do
    it 'is registered under its QName' do
      expect(Chemicalml::Convention.lookup('convention:cascade'))
        .to eq(Chemicalml::Convention::Cascade)
    end

    it 'exposes the convention namespace' do
      expect(Chemicalml::Convention::Cascade.namespace_uri)
        .to eq('http://www.xml-cml.org/convention/cascade')
    end
  end

  describe 'ReactionSchemeMustHaveContent' do
    it 'flags an empty reactionScheme' do
      scheme = scheme_class.new(id: 'rs1')
      violations = validate(scheme)
      expect(violations.map(&:message))
        .to include(match(/reactionScheme .* must contain at least one reactionStepList or reaction/))
    end

    it 'passes when the scheme contains a reactionStepList' do
      scheme = scheme_class.new(
        id: 'rs1',
        reaction_step_lists: [list_class.new(
          reaction_steps: [step_class.new(reaction: reaction_class.new)]
        )]
      )
      violations = validate(scheme)
      expect(violations.map(&:message))
        .not_to include(match(/reactionScheme .* must contain/))
    end
  end

  describe 'ReactionStepListMustContainSteps' do
    it 'flags an empty reactionStepList' do
      scheme = scheme_class.new(
        id: 'rs1',
        reaction_step_lists: [list_class.new(id: 'rsl1')]
      )
      violations = validate(scheme)
      expect(violations.map(&:message))
        .to include(match(/reactionStepList must contain at least one reactionStep/))
    end

    it 'passes when the stepList contains a reactionStep' do
      scheme = scheme_class.new(
        id: 'rs1',
        reaction_step_lists: [list_class.new(
          reaction_steps: [step_class.new(reaction: reaction_class.new)]
        )]
      )
      violations = validate(scheme)
      expect(violations.map(&:message))
        .not_to include(match(/reactionStepList must contain/))
    end
  end

  describe 'ReactionStepMustHaveReactionOrLists' do
    it 'flags a step with neither a reaction nor reactant/product lists' do
      scheme = scheme_class.new(
        id: 'rs1',
        reaction_step_lists: [list_class.new(
          reaction_steps: [step_class.new(id: 'st1')]
        )]
      )
      violations = validate(scheme)
      expect(violations.map(&:message))
        .to include(match(/reactionStep .* must contain a reaction or both reactantList and productList/))
    end

    it 'passes when the step has a reaction' do
      scheme = scheme_class.new(
        id: 'rs1',
        reaction_step_lists: [list_class.new(
          reaction_steps: [step_class.new(reaction: reaction_class.new)]
        )]
      )
      violations = validate(scheme)
      expect(violations.map(&:message))
        .not_to include(match(/reactionStep .* must contain/))
    end

    it 'passes when the step has explicit reactant and product lists' do
      scheme = scheme_class.new(
        id: 'rs1',
        reaction_step_lists: [list_class.new(
          reaction_steps: [step_class.new(
            reactant_list: reactant_list_class.new,
            product_list: product_list_class.new
          )]
        )]
      )
      violations = validate(scheme)
      expect(violations.map(&:message))
        .not_to include(match(/reactionStep .* must contain/))
    end
  end

  describe 'ReactiveCentreAtomRefsShouldBePresent' do
    it 'warns when atomRefs is missing' do
      centre = reactive_centre_class.new(id: 'rc1')
      violations = validate(centre)
      warning = violations.find { |v| v.message.match?(/should declare atomRefs/) }
      expect(warning).not_to be_nil
      expect(warning.severity).to eq(:warning)
    end

    it 'passes when atomRefs is present' do
      centre = reactive_centre_class.new(id: 'rc1', atomRefs: 'a1 a2')
      violations = validate(centre)
      expect(violations.map(&:message))
        .not_to include(match(/should declare atomRefs/))
    end
  end
end
