# frozen_string_literal: true

require "lutaml/model"

module Chemml
  module Cml
    # CML `<name>` element. Carries the molecule's common or
    # systematic name as character content.
    class Name < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :convention, :string
      attribute :dict_ref, :string

      xml do
        root "name"
        map_content to: :content
        map_attribute "convention", to: :convention
        map_attribute "dictRef", to: :dict_ref
      end
    end
  end
end
