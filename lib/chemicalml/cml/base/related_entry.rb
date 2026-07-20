# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module RelatedEntry
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::RelatedEntry

            attribute :related_entry_type, :string
            attribute :type, :string
            attribute :href, :string
            attribute :content, :string

            xml do
              namespace Chemicalml::Cml::Namespace
              root 'relatedEntry'
              map_attribute 'relatedEntryType', to: :related_entry_type
              map_attribute 'type', to: :type
              map_attribute 'href', to: :href
              map_content to: :content
            end
            key_value do
              map 'relatedEntryType', to: :related_entry_type
              map 'type', to: :type
              map 'href', to: :href
            end
          end
        end
      end
    end
  end
end
