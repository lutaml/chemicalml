# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module IsotopeList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::IsotopeList
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :isotopes, :isotope, collection: true

            attribute :ref, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "isotope", to: :isotopes
              root "isotopeList"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "ref", to: :ref
            end
            key_value do
              map "isotope", to: :isotopes
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "ref", to: :ref
            end

          end
        end
      end
    end
  end
end