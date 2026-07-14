# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Description < Lutaml::Model::Serializable
        include Base::Description
        include Visitable
        extend Context
      end
    end
  end
end
