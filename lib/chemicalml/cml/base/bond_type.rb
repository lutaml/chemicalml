# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module BondType
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::BondType
            include Chemicalml::Cml::Base::CommonChildren

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :order, :string
            attribute :ref, :string

            attribute :name, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'bondType'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'order', to: :order
              map_attribute 'ref', to: :ref
              map_attribute 'name', to: :name
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'order', to: :order
              map 'ref', to: :ref
              map 'name', to: :name
            end
          end
        end
      end
    end
  end
end
