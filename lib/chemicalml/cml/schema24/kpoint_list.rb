# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class KpointList < Lutaml::Model::Serializable
        include Base::KpointList
        include Visitable
        extend Context
      end
    end
  end
end
