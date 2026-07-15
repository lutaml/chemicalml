# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module SubstanceList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::SubstanceList
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :substances, :substance, collection: true

            attribute :substance_list_type, :string
            attribute :role, :string
            attribute :ref, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "substance", to: :substances
              root "substanceList"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "substanceListType", to: :substance_list_type
              map_attribute "role", to: :role
              map_attribute "ref", to: :ref
            end
          end
        end
      end
    end
  end
end
