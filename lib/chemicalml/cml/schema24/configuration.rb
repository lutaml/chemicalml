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
        #
        # Also skip registering <float>, <integer>, <string> as
        # types — their ids collide with lutaml-model primitives
        # (:float, :integer, :string), and registering them would
        # shadow the primitive, breaking every attribute typed as
        # :string in any Schema24 wire class. They remain defined
        # as wire classes and parseable as document roots.
        def self.register_models!
          register_elements!(except: Chemicalml::Cml::Elements::SCHEMA3_ONLY)
          register_elements!(
            only: true,
            except: Chemicalml::Cml::Elements::SCHEMA24_TYPE_COLLISIONS
          )
        end
      end
    end
  end
end
