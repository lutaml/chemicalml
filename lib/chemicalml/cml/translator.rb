# frozen_string_literal: true

module Chemicalml
  module Cml
    # Adapter between the canonical `Chemicalml::Model` and the CML XML
    # wire-format layer (`Chemicalml::Cml::*` lutaml-model classes).
    #
    # Pure transformation. No I/O. Two public class methods, one per
    # direction. All helpers are private.
    #
    # `from_canonical` accepts a `schema:` keyword (`:schema3` default,
    # or `:schema24`) and uses `WireClassRegistry` to instantiate the
    # right wire class for every nested element — not just the
    # Document root.
    class Translator
      autoload :ValueTranslations, "chemicalml/cml/translator/value_translations"

      # Wire format -> canonical. Polymorphic: accepts either a wire
      # Document (`<cml>` root) or a wire Module (`<module>` root).
      # Dispatches via Role module checks.
      def self.to_canonical(node)
        case node
        when Chemicalml::Cml::Role::Document
          document_to_canonical(node)
        when Chemicalml::Cml::Role::Module
          module_to_canonical(node)
        else
          raise ArgumentError,
                "to_canonical accepts a wire Document or Module, " \
                "got #{node.class}"
        end
      end

      # Wire Document -> canonical Model::Document.
      def self.document_to_canonical(document)
        Model::Document.new(
          molecules: document.molecules.map { |m| molecule_to_canonical(m) },
          reactions: document.reactions.map { |r| reaction_to_canonical(r) }
        )
      end

      # Wire Module -> canonical Model::Module. Used for compchem
      # documents where the root is `<module convention="convention:compchem">`
      # rather than `<cml>`.
      def self.module_to_canonical(wire_module)
        Model::Module.new(
          id: wire_module.id,
          title: wire_module.title,
          dict_ref: wire_module.dict_ref,
          convention: wire_module.convention,
          molecules: (wire_module.molecules || []).map { |m| molecule_to_canonical(m) },
          modules: (wire_module.modules || []).map { |m| module_to_canonical(m) },
          parameter_lists: (wire_module.parameter_lists || []).map { |l| parameter_list_to_canonical(l) },
          property_lists: (wire_module.property_lists || []).map { |l| property_list_to_canonical(l) },
          metadata_lists: (wire_module.metadata_lists || []).map { |l| metadata_list_to_canonical(l) },
          lists: []
        )
      end

      # Canonical -> wire format. Polymorphic: accepts either a
      # canonical Document or a canonical Module. `schema:` selects
      # the target version (`:schema3` default, or `:schema24`).
      def self.from_canonical(node, schema: :schema3)
        case node
        when Model::Document
          document_from_canonical(node, schema: schema)
        when Model::Module
          module_from_canonical(node, schema: schema)
        else
          raise ArgumentError,
                "from_canonical accepts a canonical Document or " \
                "Module, got #{node.class}"
        end
      end

      # Canonical Document -> wire Document. All nested wire classes
      # are looked up via `WireClassRegistry.for(schema, role)` so
      # the right version's class is used at every level.
      def self.document_from_canonical(document, schema: :schema3)
        wire_doc_class(schema).new(
          molecules: document.molecules.map { |m| molecule_from_canonical(m, schema: schema) },
          reactions: document.reactions.map { |r| reaction_from_canonical(r, schema: schema) }
        )
      end

      # Canonical Model::Module -> wire Module. Compchem documents
      # are rooted at `<module>` rather than `<cml>`; this method
      # produces the corresponding wire tree (Schema 3 only — Schema
      # 2.4 lacks `<module>`).
      def self.module_from_canonical(model_module, schema: :schema3)
        registry = Chemicalml::Cml::WireClassRegistry
        registry.for(schema, Chemicalml::Cml::Role::Module).new(
          id: model_module.id,
          title: model_module.title,
          dict_ref: model_module.dict_ref,
          convention: model_module.convention,
          molecules: model_module.molecules.map { |m| molecule_from_canonical(m, schema: schema) },
          modules: model_module.modules.map { |m| module_from_canonical(m, schema: schema) },
          parameter_lists: model_module.parameter_lists.map { |l| parameter_list_from_canonical(l, schema: schema) },
          property_lists: model_module.property_lists.map { |l| property_list_from_canonical(l, schema: schema) },
          metadata_lists: model_module.metadata_lists.map { |l| metadata_list_from_canonical(l, schema: schema) },
          lists: []
        )
      end

      # -- CML -> canonical --------------------------------------------

      def self.molecule_to_canonical(cml_mol)
        Model::Molecule.new(
          id: cml_mol.id,
          atoms: cml_mol.atom_array&.atoms&.map { |a| atom_to_canonical(a) } || [],
          bonds: cml_mol.bond_array&.bonds&.map { |b| bond_to_canonical(b) } || [],
          names: cml_mol.names.map { |n| name_to_canonical(n) },
          identifiers: cml_mol.identifiers.map { |i| identifier_to_canonical(i) },
          formulas: (cml_mol.formulas || []).map { |f| formula_to_canonical(f) },
          properties: (cml_mol.properties || []).map { |p| property_to_canonical(p) },
          labels: (cml_mol.labels || []).map { |l| label_to_canonical(l) },
          count: cml_mol.count,
          formal_charge: cml_mol.formal_charge,
          title: cml_mol.title
        )
      end

      def self.name_to_canonical(cml_name)
        return nil unless cml_name

        Model::Name.new(
          content: cml_name.content,
          convention: cml_name.convention,
          dict_ref: cml_name.dict_ref
        )
      end

      def self.identifier_to_canonical(cml_id)
        return nil unless cml_id

        Model::Identifier.new(
          value: cml_id.value,
          convention: cml_id.convention,
          dict_ref: cml_id.dict_ref
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
          title: cml_atom.title,
          x2: cml_atom.x2,
          y2: cml_atom.y2,
          x3: cml_atom.x3,
          y3: cml_atom.y3,
          z3: cml_atom.z3,
          x_fract: cml_atom.xFract,
          y_fract: cml_atom.yFract,
          z_fract: cml_atom.zFract,
          atom_parity: atom_parity_to_canonical(cml_atom.atom_parity)
        )
      end

      def self.bond_to_canonical(cml_bond)
        Model::Bond.new(
          id: cml_bond.id,
          atom_refs: cml_bond.atom_refs2&.split(" ") || [],
          kind: cml_order_to_kind(cml_bond.order),
          bond_stereo: bond_stereo_to_canonical(cml_bond.bond_stereo)
        )
      end

      def self.atom_parity_to_canonical(cml_ap)
        return nil unless cml_ap

        Model::AtomParity.new(
          atom_refs4: cml_ap.atom_refs4&.split(" ") || [],
          value: cml_ap.content
        )
      end

      def self.bond_stereo_to_canonical(cml_bs)
        return nil unless cml_bs

        Model::BondStereo.new(
          value: cml_bs.content,
          atom_refs2: cml_bs.atom_refs2&.split(" "),
          atom_refs4: cml_bs.atom_refs4&.split(" "),
          dict_ref: cml_bs.dict_ref
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

      def self.property_list_to_canonical(cml_list)
        return Model::PropertyList.new unless cml_list

        Model::PropertyList.new(
          id: cml_list.id,
          title: cml_list.title,
          dict_ref: cml_list.dict_ref,
          properties: cml_list.properties.map { |p| property_to_canonical(p) }
        )
      end

      def self.parameter_list_to_canonical(cml_list)
        return Model::ParameterList.new unless cml_list

        Model::ParameterList.new(
          id: cml_list.id,
          title: cml_list.title,
          dict_ref: cml_list.dict_ref,
          parameters: cml_list.parameters.map { |p| parameter_to_canonical(p) }
        )
      end

      def self.metadata_list_to_canonical(cml_list)
        return Model::MetadataList.new unless cml_list

        Model::MetadataList.new(
          id: cml_list.id,
          title: cml_list.title,
          dict_ref: cml_list.dict_ref,
          metadata: cml_list.metadata.map { |m| metadata_to_canonical(m) }
        )
      end

      def self.property_value_to_canonical(cml_prop)
        value_container_to_canonical(cml_prop.scalar) ||
          value_container_to_canonical(cml_prop.array) ||
          value_container_to_canonical(cml_prop.matrix)
      end

      def self.parameter_value_to_canonical(cml_param)
        value_container_to_canonical(cml_param.scalar) ||
          value_container_to_canonical(cml_param.array) ||
          value_container_to_canonical(cml_param.matrix)
      end

      # -- Canonical -> CML --------------------------------------------
      # Every helper takes `schema:` and looks up wire classes via
      # WireClassRegistry so children are the right version.

      def self.molecule_from_canonical(mol, schema:)
        registry = Chemicalml::Cml::WireClassRegistry
        registry.for(schema, Chemicalml::Cml::Role::Molecule).new(
          id: mol.id,
          atom_array: mol.atoms.empty? ? nil : registry.for(schema, Chemicalml::Cml::Role::AtomArray).new(
            atoms: mol.atoms.map { |a| atom_from_canonical(a, schema: schema) }
          ),
          bond_array: mol.bonds.empty? ? nil : registry.for(schema, Chemicalml::Cml::Role::BondArray).new(
            bonds: mol.bonds.map { |b| bond_from_canonical(b, schema: schema) }
          ),
          names: mol.names.map { |n| registry.for(schema, Chemicalml::Cml::Role::Name).new(content: n.content, convention: n.convention, dict_ref: n.dict_ref) },
          identifiers: mol.identifiers.map { |i| registry.for(schema, Chemicalml::Cml::Role::Identifier).new(value: i.value, convention: i.convention, dict_ref: i.dict_ref) },
          formulas: mol.formulas.map { |f| formula_from_canonical(f, schema: schema) },
          properties: mol.properties.map { |p| property_from_canonical(p, schema: schema) },
          labels: mol.labels.map { |l| label_from_canonical(l, schema: schema) },
          count: mol.count,
          formal_charge: mol.formal_charge,
          title: mol.title
        )
      end

      def self.atom_from_canonical(atom, schema:)
        Chemicalml::Cml::WireClassRegistry
          .for(schema, Chemicalml::Cml::Role::Atom)
          .new(
            id: atom.id,
            element_type: atom.element,
            formal_charge: atom.formal_charge,
            isotope: atom.isotope,
            count: atom.count,
            hydrogen_count: atom.hydrogen_count,
            spin_multiplicity: atom.spin_multiplicity,
            title: atom.title,
            x2: atom.x2,
            y2: atom.y2,
            x3: atom.x3,
            y3: atom.y3,
            z3: atom.z3,
            xFract: atom.x_fract,
            yFract: atom.y_fract,
            zFract: atom.z_fract,
            atom_parity: atom_parity_from_canonical(atom.atom_parity, schema: schema)
          )
      end

      def self.bond_from_canonical(bond, schema:)
        Chemicalml::Cml::WireClassRegistry
          .for(schema, Chemicalml::Cml::Role::Bond)
          .new(
            id: bond.id,
            atom_refs2: bond.atom_refs.join(" "),
            order: bond.cml_order,
            bond_stereo: bond_stereo_from_canonical(bond.bond_stereo, schema: schema)
          )
      end

      def self.atom_parity_from_canonical(ap, schema:)
        return nil unless ap

        Chemicalml::Cml::WireClassRegistry
          .for(schema, Chemicalml::Cml::Role::AtomParity)
          .new(
            atom_refs4: [*ap.atom_refs4].join(" "),
            content: ap.value
          )
      end

      def self.bond_stereo_from_canonical(bs, schema:)
        return nil unless bs

        Chemicalml::Cml::WireClassRegistry
          .for(schema, Chemicalml::Cml::Role::BondStereo)
          .new(
            content: bs.value,
            atom_refs2: bs.atom_refs2 && [*bs.atom_refs2].join(" "),
            atom_refs4: bs.atom_refs4 && [*bs.atom_refs4].join(" "),
            dict_ref: bs.dict_ref
          )
      end

      def self.reaction_from_canonical(rxn, schema:)
        Chemicalml::Cml::WireClassRegistry
          .for(schema, Chemicalml::Cml::Role::Reaction)
          .new(
            id: rxn.id,
            title: rxn.title || rxn.arrow.to_s,
            type: rxn.type || rxn.arrow.to_s,
            reactant_list: reactant_list_from_canonical(rxn.reactant_list, schema: schema),
            product_list: product_list_from_canonical(rxn.product_list, schema: schema)
          )
      end

      def self.reactant_list_from_canonical(list, schema:)
        registry = Chemicalml::Cml::WireClassRegistry
        registry.for(schema, Chemicalml::Cml::Role::ReactantList).new(
          reactants: list.reactants.map do |r|
            registry.for(schema, Chemicalml::Cml::Role::Reactant).new(
              substance: registry.for(schema, Chemicalml::Cml::Role::Substance).new(
                molecule: molecule_from_canonical(r.substance.molecule, schema: schema),
                title: r.substance.title,
                role: r.substance.role
              )
            )
          end
        )
      end

      def self.product_list_from_canonical(list, schema:)
        registry = Chemicalml::Cml::WireClassRegistry
        registry.for(schema, Chemicalml::Cml::Role::ProductList).new(
          products: list.products.map do |p|
            registry.for(schema, Chemicalml::Cml::Role::Product).new(
              substance: registry.for(schema, Chemicalml::Cml::Role::Substance).new(
                molecule: molecule_from_canonical(p.substance.molecule, schema: schema),
                title: p.substance.title,
                role: p.substance.role
              )
            )
          end
        )
      end

      def self.property_list_from_canonical(list, schema:)
        registry = Chemicalml::Cml::WireClassRegistry
        registry.for(schema, Chemicalml::Cml::Role::PropertyList).new(
          id: list.id,
          title: list.title,
          dict_ref: list.dict_ref,
          properties: list.properties.map { |p| property_from_canonical(p, schema: schema) }
        )
      end

      def self.parameter_list_from_canonical(list, schema:)
        registry = Chemicalml::Cml::WireClassRegistry
        registry.for(schema, Chemicalml::Cml::Role::ParameterList).new(
          id: list.id,
          title: list.title,
          dict_ref: list.dict_ref,
          parameters: list.parameters.map { |p| parameter_from_canonical(p, schema: schema) }
        )
      end

      def self.metadata_list_from_canonical(list, schema:)
        registry = Chemicalml::Cml::WireClassRegistry
        registry.for(schema, Chemicalml::Cml::Role::MetadataList).new(
          id: list.id,
          title: list.title,
          dict_ref: list.dict_ref,
          metadata: list.metadata.map { |m| metadata_from_canonical(m, schema: schema) }
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

      def self.wire_doc_class(schema)
        Chemicalml::Cml::WireClassRegistry.for(schema, Chemicalml::Cml::Role::Document)
      end

      extend ValueTranslations::ClassMethods

      # Truly internal helpers — not part of the public API. Public
      # per-element translation methods (`molecule_to_canonical`,
      # `scalar_from_canonical`, etc.) remain public because callers
      # may need to translate a single element without a full
      # Document wrapper.
      private_class_method :cml_order_to_kind, :type_to_arrow,
                           :wire_doc_class,
                           :document_to_canonical, :document_from_canonical,
                           :property_value_to_canonical, :parameter_value_to_canonical,
                           :value_container_to_canonical, :value_container_from_canonical
    end
  end
end
