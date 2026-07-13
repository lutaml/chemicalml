# frozen_string_literal: true

module Chemicalml
  module Cml
    # Adapter between the canonical `Chemicalml::Model` and the CML XML
    # wire-format layer (`Chemicalml::Cml::*` lutaml-model classes).
    #
    # Pure transformation. No I/O. Two class methods, one per
    # direction. Adding a new CML element means updating the
    # translator's mapping rules; the canonical classes and the CML
    # wire classes stay independent.
    class Translator
      autoload :ValueTranslations, "chemicalml/cml/translator/value_translations"

      # CML wire format -> canonical. Accepts either Schema3 or
      # Schema24 wire documents; dispatches based on class.
      def self.to_canonical(document)
        Model::Document.new(
          molecules: document.molecules.map { |m| molecule_to_canonical(m) },
          reactions: document.reactions.map { |r| reaction_to_canonical(r) }
        )
      end

      # Canonical -> CML wire format. `schema:` selects the target
      # version (`:schema3` default, or `:schema24`).
      def self.from_canonical(document, schema: :schema3)
        wire_class = document_class_for(schema)
        wire_class.new(
          molecules: document.molecules.map { |m| molecule_from_canonical(m) },
          reactions: document.reactions.map { |r| reaction_from_canonical(r) }
        )
      end

      def self.document_class_for(schema)
        case schema.to_sym
        when :schema3  then Chemicalml::Cml::Schema3::Document
        when :schema24 then Chemicalml::Cml::Schema24::Document
        else
          raise ArgumentError, "unsupported schema: #{schema.inspect}"
        end
      end
      private_class_method :document_class_for

      # -- CML -> canonical --------------------------------------------

      def self.molecule_to_canonical(cml_mol)
        Model::Molecule.new(
          id: cml_mol.id,
          atoms: cml_mol.atom_array&.atoms&.map { |a| atom_to_canonical(a) } || [],
          bonds: cml_mol.bond_array&.bonds&.map { |b| bond_to_canonical(b) } || [],
          names: cml_mol.names.map { |n| Model::Name.new(content: n.content, convention: n.convention, dict_ref: n.dict_ref) },
          identifiers: cml_mol.identifiers.map { |i| Model::Identifier.new(value: i.value, convention: i.convention, dict_ref: i.dict_ref) },
          count: cml_mol.count,
          formal_charge: cml_mol.formal_charge,
          title: cml_mol.title
        )
      end

      def self.atom_to_canonical(cml_atom)
        Model::Atom.new(
          id: cml_atom.id,
          element: cml_atom.element_type,
          formal_charge: cml_atom.formal_charge,
          isotope: cml_atom.isotope,
          count: cml_atom.count,
          hydrogen_count: cml_atom.hydrogen_count,
          spin_multiplicity: cml_atom.spin_multiplicity,
          title: cml_atom.title
        )
      end

      def self.bond_to_canonical(cml_bond)
        Model::Bond.new(
          id: cml_bond.id,
          atom_refs: cml_bond.atom_refs2&.split(" ") || [],
          kind: cml_order_to_kind(cml_bond.order)
        )
      end

      def self.reaction_to_canonical(cml_rxn)
        Model::Reaction.new(
          id: cml_rxn.id,
          reactant_list: reactant_list_to_canonical(cml_rxn.reactant_list),
          product_list: product_list_to_canonical(cml_rxn.product_list),
          arrow: type_to_arrow(cml_rxn.type || cml_rxn.title),
          title: cml_rxn.title,
          type: cml_rxn.type
        )
      end

      def self.reactant_list_to_canonical(cml_list)
        return Model::ReactantList.new unless cml_list

        Model::ReactantList.new(
          reactants: cml_list.reactants.map do |r|
            Model::Reactant.new(
              substance: Model::Substance.new(
                molecule: molecule_to_canonical(r.substance.molecule),
                title: r.substance.title,
                role: r.substance.role
              )
            )
          end
        )
      end

      def self.product_list_to_canonical(cml_list)
        return Model::ProductList.new unless cml_list

        Model::ProductList.new(
          products: cml_list.products.map do |p|
            Model::Product.new(
              substance: Model::Substance.new(
                molecule: molecule_to_canonical(p.substance.molecule),
                title: p.substance.title,
                role: p.substance.role
              )
            )
          end
        )
      end

      # -- Canonical -> CML --------------------------------------------

      def self.molecule_from_canonical(mol)
        Cml::Molecule.new(
          id: mol.id,
          atom_array: mol.atoms.empty? ? nil : Cml::AtomArray.new(
            atoms: mol.atoms.map { |a| atom_from_canonical(a) }
          ),
          bond_array: mol.bonds.empty? ? nil : Cml::BondArray.new(
            bonds: mol.bonds.map { |b| bond_from_canonical(b) }
          ),
          names: mol.names.map { |n| Cml::Name.new(content: n.content, convention: n.convention, dict_ref: n.dict_ref) },
          identifiers: mol.identifiers.map { |i| Cml::Identifier.new(value: i.value, convention: i.convention, dict_ref: i.dict_ref) },
          count: mol.count,
          formal_charge: mol.formal_charge,
          title: mol.title
        )
      end

      def self.atom_from_canonical(atom)
        Cml::Atom.new(
          id: atom.id,
          element_type: atom.element,
          formal_charge: atom.formal_charge,
          isotope: atom.isotope,
          count: atom.count,
          hydrogen_count: atom.hydrogen_count,
          spin_multiplicity: atom.spin_multiplicity,
          title: atom.title
        )
      end

      def self.bond_from_canonical(bond)
        Cml::Bond.new(
          id: bond.id,
          atom_refs2: bond.atom_refs.join(" "),
          order: bond.cml_order
        )
      end

      def self.reaction_from_canonical(rxn)
        Cml::Reaction.new(
          id: rxn.id,
          title: rxn.title || rxn.arrow.to_s,
          type: rxn.type || rxn.arrow.to_s,
          reactant_list: reactant_list_from_canonical(rxn.reactant_list),
          product_list: product_list_from_canonical(rxn.product_list)
        )
      end

      def self.reactant_list_from_canonical(list)
        Cml::ReactantList.new(
          reactants: list.reactants.map do |r|
            Cml::Reactant.new(
              substance: Cml::Substance.new(
                molecule: molecule_from_canonical(r.substance.molecule),
                title: r.substance.title,
                role: r.substance.role
              )
            )
          end
        )
      end

      def self.product_list_from_canonical(list)
        Cml::ProductList.new(
          products: list.products.map do |p|
            Cml::Product.new(
              substance: Cml::Substance.new(
                molecule: molecule_from_canonical(p.substance.molecule),
                title: p.substance.title,
                role: p.substance.role
              )
            )
          end
        )
      end

      # -- Lookup tables -----------------------------------------------

      ORDER_TO_KIND = {
        "S" => :single, "D" => :double, "T" => :triple,
        "Q" => :quadruple, "A" => :aromatic, "W" => :wedge,
        "H" => :hash, "DG" => :dative, "V" => :wavy
      }.freeze

      TYPE_TO_ARROW = {
        "forward" => :forward,
        "reverse" => :reverse,
        "equilibrium" => :equilibrium,
        "resonance" => :resonance
      }.freeze

      def self.cml_order_to_kind(order)
        return :single if order.nil?

        ORDER_TO_KIND.fetch(order.upcase, :single)
      end

      def self.type_to_arrow(value)
        return :forward if value.nil?

        TYPE_TO_ARROW.fetch(value.to_s.downcase, :forward)
      end

      private_class_method :cml_order_to_kind, :type_to_arrow

      extend ValueTranslations::ClassMethods
    end
  end
end
