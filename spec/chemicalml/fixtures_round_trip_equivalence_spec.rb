# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'XML round-trip equivalence (TODO 95)' do
  before do
    Chemicalml::Cml::Schema3::Configuration.ensure_registered!
  end

  Dir.glob('spec/fixtures/schema3/**/*.cml').sort.each do |path|
    it "#{path.sub('spec/fixtures/schema3/', '')} parses → serialises → parses with structural equality" do
      xml1 = File.read(path)
      doc1 = Chemicalml.parse(xml1, schema: :schema3)

      xml2 = Chemicalml.serialize(doc1)
      expect(xml2).to be_a(String)
      expect(xml2).not_to be_empty

      doc2 = Chemicalml.parse(xml2, schema: :schema3)
      expect(doc2.class).to eq(doc1.class)

      # Structural fingerprint — count of every element type reachable
      fingerprint1 = structural_fingerprint(doc1)
      fingerprint2 = structural_fingerprint(doc2)
      expect(fingerprint2).to eq(fingerprint1),
                               "round-trip drift in #{path}: #{fingerprint1} vs #{fingerprint2}"
    end
  end

  # Hash of element_name → count. Recursively walks every wire child.
  def structural_fingerprint(node, counts = Hash.new(0))
    return counts unless node.is_a?(Lutaml::Model::Serializable)

    name = node.class.name.split('::').last
    counts[name] += 1

    if node.is_a?(Chemicalml::Cml::Visitable)
      node.wire_children.each { |c| structural_fingerprint(c, counts) }
    end
    counts
  end
end
