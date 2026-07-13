# frozen_string_literal: true

require "lutaml/model"

module Chemml
  # CML model layer. Each class in this namespace maps to a CML XML
  # element and is a `Lutaml::Model::Serializable` subclass.
  module Cml
    autoload :Atom, "chemml/cml/atom"
    autoload :AtomArray, "chemml/cml/atom_array"
    autoload :Bond, "chemml/cml/bond"
    autoload :BondArray, "chemml/cml/bond_array"
    autoload :Document, "chemml/cml/document"
    autoload :Identifier, "chemml/cml/identifier"
    autoload :Molecule, "chemml/cml/molecule"
    autoload :Name, "chemml/cml/name"
    autoload :Namespace, "chemml/cml/namespace"
    autoload :Product, "chemml/cml/product"
    autoload :ProductList, "chemml/cml/product_list"
    autoload :Reaction, "chemml/cml/reaction"
    autoload :ReactionList, "chemml/cml/reaction_list"
    autoload :Reactant, "chemml/cml/reactant"
    autoload :ReactantList, "chemml/cml/reactant_list"
    autoload :Substance, "chemml/cml/substance"
  end
end
