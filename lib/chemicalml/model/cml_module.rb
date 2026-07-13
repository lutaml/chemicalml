# frozen_string_literal: true

module Chemicalml
  module Model
    # A generic grouping container (CML `<module>`). The `dict_ref`
    # attribute identifies the module's role (e.g.
    # `compchem:jobList`, `compchem:initialization`).
    class Module < Node
      attr_accessor :id, :title, :dict_ref, :convention,
                    :molecules, :modules, :parameter_lists,
                    :property_lists, :metadata_lists, :lists

      def initialize(id: nil, title: nil, dict_ref: nil, convention: nil,
                     molecules: [], modules: [],
                     parameter_lists: [], property_lists: [],
                     metadata_lists: [], lists: [])
        @id = id
        @title = title
        @dict_ref = dict_ref
        @convention = convention
        @molecules = molecules
        @modules = modules
        @parameter_lists = parameter_lists
        @property_lists = property_lists
        @metadata_lists = metadata_lists
        @lists = lists
      end

      def children
        molecules + modules + parameter_lists + property_lists + metadata_lists + lists
      end

      def value_attributes
        {
          id: id, title: title, dict_ref: dict_ref, convention: convention,
          molecules: molecules, modules: modules,
          parameter_lists: parameter_lists,
          property_lists: property_lists,
          metadata_lists: metadata_lists,
          lists: lists
        }
      end
    end
  end
end
