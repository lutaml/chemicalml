# frozen_string_literal: true

module Chemicalml
  module Model
    # Canonical formula. Three complementary forms: a structured
    # `atom_array`, a `concise` string (e.g. "C 1 H 4 O 1"), or an
    # `inline` representation (e.g. LaTeX "H_{3}C-OH").
    class Formula < Node
      attr_accessor :id, :concise, :inline, :formal_charge, :count,
                    :title, :convention, :dict_ref

      def initialize(id: nil, concise: nil, inline: nil,
                     formal_charge: nil, count: nil, title: nil,
                     convention: nil, dict_ref: nil)
        @id = id
        @concise = concise
        @inline = inline
        @formal_charge = formal_charge
        @count = count
        @title = title
        @convention = convention
        @dict_ref = dict_ref
      end

      def value_attributes
        {
          id: id, concise: concise, inline: inline,
          formal_charge: formal_charge, count: count, title: title,
          convention: convention, dict_ref: dict_ref
        }
      end
    end
  end
end
