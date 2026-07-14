# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module PeakList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::PeakList
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

                        attribute :peaks, :peak, collection: true
            attribute :peak_groups, :peakGroup, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "peak", to: :peaks
              map_element "peakGroup", to: :peak_groups
              root "peakList"
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
