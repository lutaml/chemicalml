# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class TableContent < Lutaml::Model::Serializable
        include Base::TableContent
        include Visitable
        extend Context
      end
    end
  end
end
