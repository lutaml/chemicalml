# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      # Mixed into every Schema24 wire class via `extend Context`.
      # Provides `lutaml_default_register` so lutaml-model can resolve
      # child element types in the Schema24 context.
      #
      # Defined once here instead of in 35 per-class files.
      module Context
        def lutaml_default_register
          :chemicalml_schema24
        end
      end
    end
  end
end
