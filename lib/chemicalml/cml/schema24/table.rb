# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Table < Lutaml::Model::Serializable
        include Base::Table
        include Visitable
        extend Context
      end
    end
  end
end
