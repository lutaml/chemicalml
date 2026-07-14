# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ReactiveCentre
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ReactiveCentre
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :atomRefs, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "reactiveCentre"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "atomRefs", to: :atomRefs
            end
          end
        end
      end
    end
  end
end
