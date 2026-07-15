# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Join
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Join
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :atomRefs2, :string

            attribute :ref, :string
            attribute :molecule_refs2, :string
            attribute :order, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "join"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "atomRefs2", to: :atomRefs2
              map_attribute "ref", to: :ref
              map_attribute "moleculeRefs2", to: :molecule_refs2
              map_attribute "order", to: :order
            end
          end
        end
      end
    end
  end
end
