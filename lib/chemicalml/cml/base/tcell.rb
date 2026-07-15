# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Tcell
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Tcell
            attribute :units, :string
            attribute :data_type, :string
            attribute :title, :string
            attribute :id, :string
            attribute :convention, :string
            attribute :dict_ref, :string
            attribute :content, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "tcell"
              map_attribute "units", to: :units
              map_attribute "dataType", to: :data_type
              map_attribute "title", to: :title
              map_attribute "id", to: :id
              map_attribute "convention", to: :convention
              map_attribute "dictRef", to: :dict_ref
              map_content to: :content
            end
          end
        end
      end
    end
  end
end
