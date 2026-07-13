# frozen_string_literal: true

require "spec_helper"

RSpec.describe Chemicalml::Cml::Reaction do
  let(:reaction) do
    described_class.new(
      id: "r1",
      title: "Haber",
      type: "equilibrium",
      reactant_list: Chemicalml::Cml::ReactantList.new(
        reactants: [
          Chemicalml::Cml::Reactant.new(
            substance: Chemicalml::Cml::Substance.new(
              molecule: Chemicalml::Cml::Molecule.new(
                id: "r-m1",
                atom_array: Chemicalml::Cml::AtomArray.new(
                  atoms: [Chemicalml::Cml::Atom.new(id: "a1", element_type: "N", count: "1")]
                )
              )
            )
          )
        ]
      ),
      product_list: Chemicalml::Cml::ProductList.new(
        products: [
          Chemicalml::Cml::Product.new(
            substance: Chemicalml::Cml::Substance.new(
              molecule: Chemicalml::Cml::Molecule.new(
                id: "p-m1",
                atom_array: Chemicalml::Cml::AtomArray.new(
                  atoms: [
                    Chemicalml::Cml::Atom.new(id: "pa1", element_type: "N", count: "1"),
                    Chemicalml::Cml::Atom.new(id: "pa2", element_type: "H", count: "3")
                  ]
                )
              )
            )
          )
        ]
      )
    )
  end

  it "serialises reactant and product lists" do
    xml = reaction.to_xml
    expect(xml).to include("<reactantList>")
    expect(xml).to include("<productList>")
    expect(xml).to include('title="Haber"')
    expect(xml).to include('type="equilibrium"')
  end

  it "round-trips through XML preserving the structure" do
    re_parsed = described_class.from_xml(reaction.to_xml)
    expect(re_parsed.title).to eq("Haber")
    expect(re_parsed.type).to eq("equilibrium")
    reactant_atoms = re_parsed.reactant_list.reactants.first.substance.molecule.atom_array.atoms
    expect(reactant_atoms.map(&:element_type)).to eq(%w[N])
    product_atoms = re_parsed.product_list.products.first.substance.molecule.atom_array.atoms
    expect(product_atoms.map(&:element_type)).to eq(%w[N H])
  end
end
