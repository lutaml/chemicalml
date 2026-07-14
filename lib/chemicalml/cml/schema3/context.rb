# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      # Mixed into every Schema3 wire class via `extend Context`.
      # Provides `lutaml_default_register` so lutaml-model can resolve
      # child element types in the Schema3 context.
      #
      # Defined once here instead of in 36 per-class files.
      module Context
        def lutaml_default_register
          :chemicalml_schema3
        end
      end
    end
  end
end
