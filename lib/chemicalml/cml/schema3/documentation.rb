# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema3
      class Documentation < Lutaml::Model::Serializable
        include Base::Documentation
        include Visitable
        extend Context
      end
    end
  end
end
