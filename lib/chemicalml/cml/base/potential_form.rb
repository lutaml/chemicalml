# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module PotentialForm
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::PotentialForm
            include Chemicalml::Cml::Base::CommonChildren

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :type, :string

            attribute :name, :string
            attribute :args, :arg, collection: true
            attribute :expression, :expression
            attribute :parameters, :parameter, collection: true
            xml do
              namespace Chemicalml::Cml::Namespace
              root 'potentialForm'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'type', to: :type
              map_attribute 'name', to: :name
              map_element 'arg', to: :args
              map_element 'expression', to: :expression
              map_element 'parameter', to: :parameters
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'arg', to: :args
              map 'expression', to: :expression
              map 'parameter', to: :parameters
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'type', to: :type
              map 'name', to: :name
            end
          end
        end
      end
    end
  end
end
