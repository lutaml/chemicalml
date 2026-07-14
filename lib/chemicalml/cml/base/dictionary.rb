# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Dictionary
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Dictionary
            attribute :title, :string
            attribute :namespace, :string
            attribute :dictionary_prefix, :string
            attribute :convention, :string
            attribute :description, :string
            attribute :entries, :entry, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root "dictionary"
              map_attribute "title", to: :title
              map_attribute "namespace", to: :namespace
              map_attribute "dictionaryPrefix", to: :dictionary_prefix
              map_attribute "convention", to: :convention
              map_element "description", to: :description
              map_element "entry", to: :entries
            end
          end
        end
      end
    end
  end
end
