# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Line3 < Lutaml::Model::Serializable
        include Base::Line3
        include Visitable
        extend Context
      end
    end
  end
end
