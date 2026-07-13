# frozen_string_literal: true

module Chemml
  # Canonical chemistry representation model. Format-agnostic plain
  # Ruby classes; not tied to any wire format.
  #
  # Every adapter (CML XML, AsciiChem text, future SMILES/InChI/MOL)
  # speaks the canonical model. Adapters never talk to each other
  # directly — only through these classes.
  module Model
    autoload :Atom, "chemml/model/atom"
    autoload :Bond, "chemml/model/bond"
    autoload :Document, "chemml/model/document"
    autoload :Identifier, "chemml/model/identifier"
    autoload :Molecule, "chemml/model/molecule"
    autoload :Name, "chemml/model/name"
    autoload :Node, "chemml/model/node"
    autoload :Product, "chemml/model/product"
    autoload :ProductList, "chemml/model/product_list"
    autoload :Reaction, "chemml/model/reaction"
    autoload :ReactionList, "chemml/model/reaction_list"
    autoload :Reactant, "chemml/model/reactant"
    autoload :ReactantList, "chemml/model/reactant_list"
    autoload :Substance, "chemml/model/substance"
  end
end
