# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      module Configuration
        extend Chemicalml::ContextConfiguration

        CONTEXT_ID = :chemicalml_schema24

        # Schema 2.4 lacks <anyCml> (Schema 3 only) — skip its
        # registration. Schema 2.4 also declares three legacy
        # elements (<annotation>, <appinfo>, <enumeration>) not in
        # Schema 3; register those explicitly from SCHEMA24_ONLY.
        def self.register_models!
          register_elements!(except: Chemicalml::Cml::Elements::SCHEMA3_ONLY)
          register_elements!(only: true)
        end
      end
    end
  end
end
