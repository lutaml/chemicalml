# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class TableCell < Lutaml::Model::Serializable
        include Base::TableCell
        include Visitable
        extend Context
      end
    end
  end
end
