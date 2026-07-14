# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class MechanismComponent < Lutaml::Model::Serializable
        include Base::MechanismComponent
        include Visitable
        extend Context
      end
    end
  end
end
