# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Angle
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Angle
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :atomRefs3, :string
            attribute :units, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "angle"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "atomRefs3", to: :atomRefs3
              map_attribute "units", to: :units
            end
          end
        end
      end
    end
  end
end
