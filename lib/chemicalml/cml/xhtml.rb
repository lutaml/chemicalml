# frozen_string_literal: true

module Chemicalml
  module Cml
    # The XHTML rich-text vocabulary CML dictionaries embed inside
    # <definition>/<description>. Each element is its own wire class
    # so the namespace travels with it (lutaml-model assigns one
    # namespace per model class).
    module Xhtml
      # The XHTML namespace CML dictionaries use for rich text content
      # (<xhtml:p> inside <definition>/<description>).
      class Namespace < Lutaml::Xml::W3c::XmlNamespace
        uri 'http://www.w3.org/1999/xhtml'
        prefix_default 'xhtml'
      end

      autoload :P, 'chemicalml/cml/xhtml/p'
    end
  end
end
