# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class TableHeaderCell < Lutaml::Model::Serializable
        include Base::TableHeaderCell
        include Visitable
        extend Context
      end
    end
  end
end
