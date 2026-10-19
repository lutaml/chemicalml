# frozen_string_literal: true

module Chemicalml
  module Cml
    module Xhtml
      # An <xhtml:p> paragraph inside CML dictionary rich text.
      class P < Lutaml::Model::Serializable
        attribute :content, :string

        xml do
          namespace Chemicalml::Cml::Xhtml::Namespace
          root 'p'
          map_content to: :content
        end
        key_value do
          map 'content', to: :content
        end
      end
    end
  end
end
