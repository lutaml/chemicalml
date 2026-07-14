# frozen_string_literal: true

module Chemicalml
  module Cml
    module Base
      module BondArray
        def self.included(klass)
          klass.class_eval do
            include Chemicalml::Cml::Role::BondArray
            attribute :bonds, :bond, collection: true

            xml do
              namespace Chemicalml::Cml::Namespace
              root "bondArray"
              map_element "bond", to: :bonds
            end
          end
        end
      end
    end
  end
end
