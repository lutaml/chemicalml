# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Arg
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Arg
            attribute :title, :string
            attribute :id, :string
            attribute :convention, :string
            attribute :dict_ref, :string
            attribute :ref, :string
            attribute :name, :string
            attribute :data_type, :string
            attribute :substitute, :string
            attribute :parameter_name, :string
            attribute :parent_attribute, :string
            attribute :delete, :string
            attribute :eval, :string
            attribute :content, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "arg"
              map_attribute "title", to: :title
              map_attribute "id", to: :id
              map_attribute "convention", to: :convention
              map_attribute "dictRef", to: :dict_ref
              map_attribute "ref", to: :ref
              map_attribute "name", to: :name
              map_attribute "dataType", to: :data_type
              map_attribute "substitute", to: :substitute
              map_attribute "parameterName", to: :parameter_name
              map_attribute "parentAttribute", to: :parent_attribute
              map_attribute "delete", to: :delete
              map_attribute "eval", to: :eval
              map_content to: :content
            end
          end
        end
      end
    end
  end
end
