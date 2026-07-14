# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Transform3 < Lutaml::Model::Serializable
        include Base::Transform3
        include Visitable
        extend Context
      end
    end
  end
end
