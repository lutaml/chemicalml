# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Link
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Link
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :href, :string
            attribute :rel, :string
            attribute :title, :string
            attribute :type, :string
            attribute :role, :string

            attribute :from, :string
            attribute :to, :string
            attribute :ref, :string
            attribute :from_type, :string
            attribute :to_type, :string
            attribute :from_set, :string
            attribute :to_set, :string
            attribute :from_context, :string
            attribute :to_context, :string
            attribute :link_type, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              root "link"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "href", to: :href
              map_attribute "rel", to: :rel
              map_attribute "title", to: :title
              map_attribute "type", to: :type
              map_attribute "role", to: :role
              map_attribute "from", to: :from
              map_attribute "to", to: :to
              map_attribute "ref", to: :ref
              map_attribute "fromType", to: :from_type
              map_attribute "toType", to: :to_type
              map_attribute "fromSet", to: :from_set
              map_attribute "toSet", to: :to_set
              map_attribute "fromContext", to: :from_context
              map_attribute "toContext", to: :to_context
              map_attribute "linkType", to: :link_type
            end
          end
        end
      end
    end
  end
end
