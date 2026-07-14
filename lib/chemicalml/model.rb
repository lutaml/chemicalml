# frozen_string_literal: true

module Chemicalml
  # Canonical chemistry representation model. Format-agnostic plain
  # Ruby classes; not tied to any wire format.
  #
  # Every adapter (CML XML, AsciiChem text, future SMILES/InChI/MOL)
  # speaks the canonical model. Adapters never talk to each other
  # directly — only through these classes.
  module Model
    autoload :Array, "chemicalml/model/cml_array"
    autoload :Atom, "chemicalml/model/atom"
    autoload :AtomParity, "chemicalml/model/atom_parity"
    autoload :Bond, "chemicalml/model/bond"
    autoload :BondStereo, "chemicalml/model/bond_stereo"
    autoload :Document, "chemicalml/model/document"
    autoload :Formula, "chemicalml/model/formula"
    autoload :Identifier, "chemicalml/model/identifier"
    autoload :Label, "chemicalml/model/label"
    autoload :Matrix, "chemicalml/model/matrix"
    autoload :Metadata, "chemicalml/model/metadata"
    autoload :MetadataList, "chemicalml/model/metadata_list"
    autoload :Module, "chemicalml/model/cml_module"
    autoload :Molecule, "chemicalml/model/molecule"
    autoload :Name, "chemicalml/model/name"
    autoload :Node, "chemicalml/model/node"
    autoload :Parameter, "chemicalml/model/parameter"
    autoload :ParameterList, "chemicalml/model/parameter_list"
    autoload :Product, "chemicalml/model/product"
    autoload :ProductList, "chemicalml/model/product_list"
    autoload :Property, "chemicalml/model/property"
    autoload :PropertyList, "chemicalml/model/property_list"
    autoload :Reaction, "chemicalml/model/reaction"
    autoload :ReactionList, "chemicalml/model/reaction_list"
    autoload :Reactant, "chemicalml/model/reactant"
    autoload :ReactantList, "chemicalml/model/reactant_list"
    autoload :Scalar, "chemicalml/model/scalar"
    autoload :Substance, "chemicalml/model/substance"
  end
end
