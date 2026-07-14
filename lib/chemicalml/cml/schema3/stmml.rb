# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Stmml < Lutaml::Model::Serializable
        include Base::Stmml
        include Visitable
        extend Context
      end
    end
  end
end
