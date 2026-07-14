# frozen_string_literal: true

module Chemicalml
  module Cml
    module Schema24
      class Link < Lutaml::Model::Serializable
        include Base::Link
        include Visitable
        extend Context
      end
    end
  end
end
