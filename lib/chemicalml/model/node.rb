# frozen_string_literal: true

module ChemicalML
  module Model
    # Base class for every canonical model node. Mirrors the contract
    # of `AsciiChem::Model::Node` so visitors written against one
    # model work against the other without modification.
    class Node
      def accept(visitor)
        visitor.public_send(:"visit_#{self.class.short_name}", self)
      rescue NoMethodError => e
        raise unless e.name == :"visit_#{self.class.short_name}"

        raise NotImplementedError,
              "#{visitor.class} does not implement visit_#{self.class.short_name}"
      end

      def ==(other)
        other.is_a?(self.class) && value_attributes == other.value_attributes
      end
      alias eql? ==

      def hash
        [self.class, value_attributes].hash
      end

      def children
        []
      end

      def value_attributes
        {}
      end

      def self.short_name
        @short_name ||= begin
          snake = name.split("::").last
                      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
                      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
          snake.downcase
        end
      end
    end
  end
end
