# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module ReactantList
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::ReactantList
            include Chemicalml::Cml::Base::CommonChildren

            attribute :reactants, :reactant, collection: true

            attribute :dict_ref, :string
            attribute :convention, :string
            attribute :title, :string
            attribute :id, :string
            attribute :ref, :string
            attribute :role, :string
            attribute :count, :string
            attribute :reactant_lists, :reactantList, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root 'reactantList'
              map_element 'reactant', to: :reactants
              map_element 'reactantList', to: :reactant_lists
              map_attribute 'dictRef', to: :dict_ref
              map_attribute 'convention', to: :convention
              map_attribute 'title', to: :title
              map_attribute 'id', to: :id
              map_attribute 'ref', to: :ref
              map_attribute 'role', to: :role
              map_attribute 'count', to: :count
            end
            key_value do
              map 'metadataList', to: :metadata_lists
              map 'label', to: :labels
              map 'name', to: :names
              map 'description', to: :descriptions
              map 'reactant', to: :reactants
              map 'reactantList', to: :reactant_lists
              map 'dictRef', to: :dict_ref
              map 'convention', to: :convention
              map 'title', to: :title
              map 'id', to: :id
              map 'ref', to: :ref
              map 'role', to: :role
              map 'count', to: :count
            end
          end
        end
      end
    end
  end
end
