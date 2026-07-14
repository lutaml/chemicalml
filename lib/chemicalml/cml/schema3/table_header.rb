# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class TableHeader < Lutaml::Model::Serializable
        include Base::TableHeader
        include Visitable
        extend Context
      end
    end
  end
end
