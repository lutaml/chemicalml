# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Spectrum
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Spectrum
            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :format, :string
            attribute :condition, :string

                        attribute :xaxis, :xaxis
            attribute :yaxis, :yaxis
            attribute :peak_list, :peakList
            attribute :condition_list, :conditionList

            attribute :ref, :string
            attribute :molecule_ref, :string
            attribute :spectrum_type, :string
            attribute :measurement, :string
            attribute :ft, :string
            attribute :state, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "xaxis", to: :xaxis
              map_element "yaxis", to: :yaxis
              map_element "peakList", to: :peak_list
              map_element "conditionList", to: :condition_list
              root "spectrum"
              map_attribute "id", to: :id
              map_attribute "title", to: :title
              map_attribute "dictRef", to: :dict_ref
              map_attribute "convention", to: :convention
              map_attribute "format", to: :format
              map_attribute "condition", to: :condition
              map_attribute "ref", to: :ref
              map_attribute "moleculeRef", to: :molecule_ref
              map_attribute "spectrumType", to: :spectrum_type
              map_attribute "measurement", to: :measurement
              map_attribute "ft", to: :ft
              map_attribute "state", to: :state
            end
          end
        end
      end
    end
  end
end
