# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module SpectrumList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::SpectrumList
            include Chemicalml::Cml::Base::CommonChildren

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string

            attribute :spectra, :spectrum

            attribute :ref, :string
            attribute :molecule_ref, :string
            attribute :spectrum_lists, :spectrumList, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              map_element 'spectrum', to: :spectra
              map_element 'spectrumList', to: :spectrum_lists
              root 'spectrumList'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'ref', to: :ref
              map_attribute 'moleculeRef', to: :molecule_ref
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'spectrum', to: :spectra
              map 'spectrumList', to: :spectrum_lists
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'ref', to: :ref
              map 'moleculeRef', to: :molecule_ref
            end
          end
        end
      end
    end
  end
end
