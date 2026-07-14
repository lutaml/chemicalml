# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class TableCell < Lutaml::Model::Serializable
        include Base::TableCell
        include Visitable
        extend Context
      end
    end
  end
end
