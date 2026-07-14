# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Electron
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Electron
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :atomRef, :string
            attribute :bondRef, :string
            attribute :count, :string
            attribute :spinMultiplicity, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "electron"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "atomRef", to: :atomRef
              map_attribute "bondRef", to: :bondRef
              map_attribute "count", to: :count
              map_attribute "spinMultiplicity", to: :spinMultiplicity
            end
          end
        end
      end
    end
  end
end
