# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module PeakStructure
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::PeakStructure
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :peakShape, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root "peakStructure"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "peakShape", to: :peakShape
            end
          end
        end
      end
    end
  end
end
