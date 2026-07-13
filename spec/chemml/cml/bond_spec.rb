# frozen_string_literal: true

require "spec_helper"

RSpec.describe Chemml::Cml::Bond do
  it "serialises with atomRefs2 and order" do
    bond = described_class.new(id: "b1", atom_refs2: "a1 a2", order: "S")
    xml = bond.to_xml
    expect(xml).to include('<bond id="b1" atomRefs2="a1 a2" order="S"/>')
  end

  it "round-trips through XML" do
    xml = '<bond id="b1" atomRefs2="a1 a2" order="D"/>'
    bond = described_class.from_xml(xml)
    expect(bond.atom_refs2).to eq("a1 a2")
    expect(bond.order).to eq("D")
  end
end
