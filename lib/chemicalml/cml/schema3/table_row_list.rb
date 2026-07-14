# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class TableRowList < Lutaml::Model::Serializable
        include Base::TableRowList
        include Visitable
        extend Context
      end
    end
  end
end
