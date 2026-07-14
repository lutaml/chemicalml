# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class CellParameter < Lutaml::Model::Serializable
        include Base::CellParameter
        include Visitable
        extend Context
      end
    end
  end
end
