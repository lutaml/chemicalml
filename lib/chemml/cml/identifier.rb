# frozen_string_literal: true

require "lutaml/model"

module Chemml
  module Cml
    # CML `<identifier>` element. Carries an external identifier
    # (InChI, SMILES, etc.) in its `value` attribute.
    class Identifier < Lutaml::Model::Serializable
      attribute :value, :string
      attribute :convention, :string
      attribute :dict_ref, :string

      xml do
        root "identifier"
        map_attribute "value", to: :value
        map_attribute "convention", to: :convention
        map_attribute "dictRef", to: :dict_ref
      end
    end
  end
end
