# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Identifier
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Identifier
            attribute :value, :string
            attribute :convention, :string
            attribute :dict_ref, :string

            xml do
            namespace Chemicalml::Cml::Namespace
              root "identifier"
              map_attribute "value", to: :value
              map_attribute "convention", to: :convention
              map_attribute "dictRef", to: :dict_ref
            end
          end
        end
      end
    end
  end
end
