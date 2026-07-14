# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Point3 < Lutaml::Model::Serializable
        include Base::Point3
        include Visitable
        extend Context
      end
    end
  end
end
