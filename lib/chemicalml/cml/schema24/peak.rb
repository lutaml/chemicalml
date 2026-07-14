# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Peak < Lutaml::Model::Serializable
        include Base::Peak
        include Visitable
        extend Context
      end
    end
  end
end
