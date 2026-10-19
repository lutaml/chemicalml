# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Document
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Document

            attribute :id, :string
            attribute :title, :string
            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :molecules, :molecule, collection: true
            attribute :reaction_lists, :reactionList, collection: true
            attribute :reactions, :reaction, collection: true
            attribute :reaction_schemes, :reactionScheme, collection: true
            attribute :spectra, :spectrum, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root 'cml'
              map_attribute 'id', to: :id
              map_attribute 'title', to: :title
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_element 'molecule', to: :molecules
              map_element 'reactionList', to: :reaction_lists
              map_element 'reaction', to: :reactions
              map_element 'reactionScheme', to: :reaction_schemes
              map_element 'spectrum', to: :spectra
            end
            key_value do
              map 'molecule', to: :molecules
              map 'reactionList', to: :reaction_lists
              map 'reaction', to: :reactions
              map 'reactionScheme', to: :reaction_schemes
              map 'spectrum', to: :spectra
              map 'id', to: :id
              map 'title', to: :title
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
            end
          end
        end
      end
    end
  end
end
