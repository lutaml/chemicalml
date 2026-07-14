# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class TableRow < Lutaml::Model::Serializable
        include Base::TableRow
        include Visitable
        extend Context
      end
    end
  end
end
