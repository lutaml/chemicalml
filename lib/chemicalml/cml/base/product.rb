# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module Product
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::Product
            attribute :substance, :substance

            xml do
              namespace Chemicalml::Cml::Namespace
              root "product"
              map_element "substance", to: :substance
            end
          end
        end
      end
    end
  end
end
