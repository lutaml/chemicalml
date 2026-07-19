# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Spectrum
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Spectrum
            include Chemicalml::Cml::Base::CommonChildren
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
            attribute :sample, :sample
            attribute :spectrum_data, :spectrumData
            attribute :parameter_lists, :parameterList, collection: true
            attribute :substance_lists, :substanceList, collection: true

            attribute :ref, :string
            attribute :molecule_ref, :string
            attribute :spectrum_type, :string
            attribute :type, :string
            attribute :measurement, :string
            attribute :ft, :string
            attribute :state, :string
            xml do
              namespace Chemicalml::Cml::Namespace
              map_element "xaxis", to: :xaxis
              map_element "yaxis", to: :yaxis
              map_element "peakList", to: :peak_list
              map_element "conditionList", to: :condition_list
              map_element "sample", to: :sample
              map_element "spectrumData", to: :spectrum_data
              map_element "parameterList", to: :parameter_lists
              map_element "substanceList", to: :substance_lists
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
              map_attribute "type", to: :type
              map_attribute "measurement", to: :measurement
              map_attribute "ft", to: :ft
              map_attribute "state", to: :state
            end
            key_value do
              map "metadataList", to: :metadata_lists
              map "label", to: :labels
              map "name", to: :names
              map "description", to: :descriptions
              map "xaxis", to: :xaxis
              map "yaxis", to: :yaxis
              map "peakList", to: :peak_list
              map "conditionList", to: :condition_list
              map "sample", to: :sample
              map "spectrumData", to: :spectrum_data
              map "parameterList", to: :parameter_lists
              map "substanceList", to: :substance_lists
              map "id", to: :id
              map "title", to: :title
              map "dictRef", to: :dict_ref
              map "convention", to: :convention
              map "format", to: :format
              map "condition", to: :condition
              map "ref", to: :ref
              map "moleculeRef", to: :molecule_ref
              map "spectrumType", to: :spectrum_type
              map "type", to: :type
              map "measurement", to: :measurement
              map "ft", to: :ft
              map "state", to: :state
            end

          end
        end
      end
    end
  end
end