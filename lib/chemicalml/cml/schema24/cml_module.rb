# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # CML <module> wire class. Schema 2.4 declares <module> in its
      # XSD (verified against `reference-docs/schemas/schema24/`), so
      # this class exists and is registered by `Schema24::Configuration`.
      # See `Chemicalml::Cml::Base::Module` for the shared attribute
      # + xml-mapping declarations.
      class Module < Lutaml::Model::Serializable
        include Base::Module
        include Visitable
        extend Context
      end
    end
  end
end
