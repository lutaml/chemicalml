# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      module Configuration
        extend Chemicalml::ContextConfiguration

        CONTEXT_ID = :chemicalml_schema3

        def self.register_models!
          register_elements!
        end
      end
    end
  end
end
