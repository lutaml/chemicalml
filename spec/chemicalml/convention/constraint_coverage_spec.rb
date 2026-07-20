# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Constraint coverage (TODO 144)' do
  # The convention framework guarantees: every registered constraint
  # class has a description, every convention registers >=1 constraint,
  # every constraint class file exists under the right path. This spec
  # verifies those invariants — catches blind spots when adding a
  # constraint but forgetting the description, or adding a convention
  # without constraints.

  it 'every registered constraint class has a non-default description' do
    Chemicalml::Convention::Registry.each_constraint do |_conv, klass|
      name = klass.name.split('::').last
      expect(klass.description).not_to eq(name),
                                       "#{name} should have a non-default description"
    end
  end

  it 'every convention registers at least one constraint' do
    Chemicalml::Convention::Registry.each do |conv|
      expect(conv.constraint_count).to be >= 1, "#{conv.qname} has no constraints"
    end
  end

  it 'every constraint class lives under Convention::*/Constraints/' do
    Chemicalml::Convention::Registry.each_constraint do |_conv, klass|
      expect(klass.name).to match(/^Chemicalml::Convention::\w+::Constraints::\w+$/),
                              "#{klass} has unexpected namespace"
    end
  end

  it 'total constraint count matches sum of per-convention counts' do
    total = Chemicalml::Convention::Registry.total_constraint_count
    sum = Chemicalml::Convention::Registry.each.sum(&:constraint_count)
    expect(total).to eq(sum)
  end

  it 'constraint count is at least 91 (the known baseline)' do
    # Catches accidental deletion of constraint registrations.
    expect(Chemicalml::Convention::Registry.total_constraint_count).to be >= 91
  end
end
