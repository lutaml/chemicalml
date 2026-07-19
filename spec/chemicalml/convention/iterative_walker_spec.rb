# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Chemicalml::Convention::Constraint do
  let(:constraint_class) do
    Class.new(described_class::NodeConstraint) do
      applies_to Chemicalml::Cml::Role::Module

      def initialize
        @visits = []
        super
      end

      attr_reader :visits

      def check_node(node, path)
        @visits << [node.id, path]
        []
      end
    end
  end

  it 'walks deeply nested modules without stack overflow' do
    # Build a 200-deep Module chain: outermost.modules[0].modules[0]...
    depth = 200
    leaf = nil
    innermost = Chemicalml::Cml::Schema3::Module.new(id: 'm0')
    depth.times do |i|
      innermost = Chemicalml::Cml::Schema3::Module.new(
        id: "m#{i + 1}",
        modules: [innermost]
      )
    end

    constraint = constraint_class.new
    constraint.check(innermost)
    # Should visit all 201 modules without raising
    expect(constraint.visits.size).to eq(depth + 1)
    expect(constraint.visits.first.first).to eq("m#{depth}")
    expect(constraint.visits.last.first).to eq('m0')
  end

  it 'walks siblings and descendants in DFS pre-order' do
    root = Chemicalml::Cml::Schema3::Module.new(
      id: 'root',
      modules: [
        Chemicalml::Cml::Schema3::Module.new(id: 'a',
                                             modules: [Chemicalml::Cml::Schema3::Module.new(id: 'a1')]),
        Chemicalml::Cml::Schema3::Module.new(id: 'b')
      ]
    )

    constraint = constraint_class.new
    constraint.check(root)
    ids_in_order = constraint.visits.map(&:first)
    expect(ids_in_order).to eq(%w[root a a1 b])
  end
end
