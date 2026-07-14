# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module PeakGroup
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::PeakGroup
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :peaks, :peak, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "peak", to: :peaks
              root "peakGroup"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
            end
          end
        end
      end
    end
  end
end
