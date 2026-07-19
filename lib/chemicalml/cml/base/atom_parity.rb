# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module AtomParity
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::AtomParity
            attribute :atom_refs4, :string
            attribute :content, :string

            attribute :title, :string
            attribute :id, :string
            attribute :convention, :string
            attribute :dict_ref, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "atomParity"
              map_attribute "atomRefs4", to: :atom_refs4
              map_content to: :content
              map_attribute "title", to: :title
              map_attribute "id", to: :id
              map_attribute "convention", to: :convention
              map_attribute "dictRef", to: :dict_ref
            end
            key_value do
              map "atomRefs4", to: :atom_refs4
              map "title", to: :title
              map "id", to: :id
              map "convention", to: :convention
              map "dictRef", to: :dict_ref
            end

          end
        end
      end
    end
  end
end