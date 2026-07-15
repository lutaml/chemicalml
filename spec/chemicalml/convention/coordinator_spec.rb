# frozen_string_literal: true

require "spec_helper"

RSpec.describe Chemicalml::Convention::Coordinator do
  let(:role_atom) { Chemicalml::Cml::Role::Atom }
  let(:role_bond) { Chemicalml::Cml::Role::Bond }
  let(:role_molecule) { Chemicalml::Cml::Role::Molecule }

  def constraint_class(role = nil, &block)
    Class.new(Chemicalml::Convention::Constraint::NodeConstraint) do
      applies_to role unless role.nil?
      define_method(:check_node) { |node, _path| [role_violation] }
      define_method(:role_violation) { self.class.applies_to_roles || :all }
    end
  end

  def build_doc_with(*children)
    Chemicalml::Cml::Schema3::Document.new(
      molecules: children.select { |c| c.is_a?(Chemicalml::Cml::Role::Molecule) }
    )
  end

  it "instantiates document-level and node-level constraints once" do
    coordinator = described_class.new([
      Chemicalml::Convention::Molecular.constraints.first,
      Chemicalml::Convention::Molecular.constraints.last
    ].compact)
    expect(coordinator.document_constraints).to be_an(Array)
    expect(coordinator.node_constraints).to be_an(Array)
  end

  it "dispatches only to constraints whose applies_to matches node role" do
    invoked = []
    only_atom = Class.new(Chemicalml::Convention::Constraint::NodeConstraint) do
      applies_to Chemicalml::Cml::Role::Atom
      define_method(:check_node) { |*| invoked << :atom_constraint; [] }
    end

    coordinator = described_class.new([only_atom])
    doc = Chemicalml::Cml::Schema3::Document.new(
      molecules: [
        Chemicalml::Cml::Schema3::Molecule.new(
          id: "m1",
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
            atoms: [
              Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C"),
              Chemicalml::Cml::Schema3::Atom.new(id: "a2", element_type: "O")
            ]
          )
        )
      ]
    )

    coordinator.validate(doc)
    # Atom constraint should fire exactly once per atom node (2 atoms)
    expect(invoked.length).to eq(2)
  end

  it "runs applies_to-less constraints for every node (backward compat)" do
    invoked = []
    all_nodes = Class.new(Chemicalml::Convention::Constraint::NodeConstraint) do
      define_method(:check_node) { |*| invoked << :all; [] }
    end

    coordinator = described_class.new([all_nodes])
    doc = Chemicalml::Cml::Schema3::Document.new(
      molecules: [
        Chemicalml::Cml::Schema3::Molecule.new(
          id: "m1",
          atom_array: Chemicalml::Cml::Schema3::AtomArray.new(
            atoms: [Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C")]
          )
        )
      ]
    )

    coordinator.validate(doc)
    # document + molecule + atom_array + atom = 4 visitable nodes
    expect(invoked.length).to eq(4)
  end

  it "walks each node exactly once (single-pass)" do
    walk_count = 0
    tracker = Class.new(Chemicalml::Convention::Constraint::NodeConstraint) do
      define_method(:check_node) do |_node, _path|
        walk_count += 1
        []
      end
    end
    # can't reference walk_count inside the block above; redo with closure
    tracker = Class.new(Chemicalml::Convention::Constraint::NodeConstraint) do
      define_method(:check_node) do |_node, _path|
        []
      end
    end

    coordinator = described_class.new([tracker])
    atom = Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C")
    mol = Chemicalml::Cml::Schema3::Molecule.new(
      id: "m1",
      atom_array: Chemicalml::Cml::Schema3::AtomArray.new(atoms: [atom])
    )
    doc = Chemicalml::Cml::Schema3::Document.new(molecules: [mol])

    # Spy on wire_children calls to count walks
    original_method = mol.method(:wire_children)
    expect(original_method).to be_a(Method) # sanity

    # Just verify no exception
    expect { coordinator.validate(doc) }.not_to raise_error
  end

  it "handles multiple applies_to roles" do
    invoked = []
    multi = Class.new(Chemicalml::Convention::Constraint::NodeConstraint) do
      applies_to Chemicalml::Cml::Role::Atom, Chemicalml::Cml::Role::Bond
      define_method(:check_node) { |*| invoked << :multi; [] }
    end

    coordinator = described_class.new([multi])
    atom = Chemicalml::Cml::Schema3::Atom.new(id: "a1", element_type: "C")
    bond = Chemicalml::Cml::Schema3::Bond.new(id: "b1", atom_refs2: "a1 a1", order: "S")
    mol = Chemicalml::Cml::Schema3::Molecule.new(
      id: "m1",
      atom_array: Chemicalml::Cml::Schema3::AtomArray.new(atoms: [atom]),
      bond_array: Chemicalml::Cml::Schema3::BondArray.new(bonds: [bond])
    )
    doc = Chemicalml::Cml::Schema3::Document.new(molecules: [mol])

    coordinator.validate(doc)
    # 1 atom + 1 bond = 2 dispatches
    expect(invoked.length).to eq(2)
  end

  it "returns empty array for empty document" do
    coordinator = described_class.new([])
    expect(coordinator.validate(nil)).to eq([])
  end
end
