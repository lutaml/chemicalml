# frozen_string_literal: true

module ChemicalML
  # Canonical chemistry representation model. Format-agnostic plain
  # Ruby classes; not tied to any wire format.
  #
  # Every adapter (CML XML, AsciiChem text, future SMILES/InChI/MOL)
  # speaks the canonical model. Adapters never talk to each other
  # directly — only through these classes.
  module Model
    autoload :Atom, "chemicalml/model/atom"
    autoload :Bond, "chemicalml/model/bond"
    autoload :Document, "chemicalml/model/document"
    autoload :Identifier, "chemicalml/model/identifier"
    autoload :Molecule, "chemicalml/model/molecule"
    autoload :Name, "chemicalml/model/name"
    autoload :Node, "chemicalml/model/node"
    autoload :Product, "chemicalml/model/product"
    autoload :ProductList, "chemicalml/model/product_list"
    autoload :Reaction, "chemicalml/model/reaction"
    autoload :ReactionList, "chemicalml/model/reaction_list"
    autoload :Reactant, "chemicalml/model/reactant"
    autoload :ReactantList, "chemicalml/model/reactant_list"
    autoload :Substance, "chemicalml/model/substance"
  end
end
