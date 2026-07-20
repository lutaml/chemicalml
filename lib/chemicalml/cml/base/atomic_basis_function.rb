# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module AtomicBasisFunction
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::AtomicBasisFunction
            include Chemicalml::Cml::Base::CommonChildren

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :atomRef, :string
            attribute :n, :string
            attribute :l, :string
            attribute :m, :string
            attribute :ms, :string
            attribute :type, :string

            attribute :symbol, :string
            attribute :lm, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'atomicBasisFunction'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'atomRef', to: :atomRef
              map_attribute 'n', to: :n
              map_attribute 'l', to: :l
              map_attribute 'm', to: :m
              map_attribute 'ms', to: :ms
              map_attribute 'type', to: :type
              map_attribute 'symbol', to: :symbol
              map_attribute 'lm', to: :lm
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
              map 'atomRef', to: :atomRef
              map 'n', to: :n
              map 'l', to: :l
              map 'm', to: :m
              map 'ms', to: :ms
              map 'type', to: :type
              map 'symbol', to: :symbol
              map 'lm', to: :lm
            end
          end
        end
      end
    end
  end
end
