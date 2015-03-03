module Infuser
  module Collections
    class Base

      def self.define_mappings map
        @mappings = map
        @standardized_fields = map.values.map(&:values).flatten.uniq
        attr_accessor *standardized_fields
        attr_accessor :id
      end

      def self.inverted_mappings
        @inverted_mappings ||= mappings.each_with_object({}) do |(key, value), hash|
          value.keys.each do |field|
            hash[field] = key
          end
        end
      end

      def self.schema
        inverted_mappings.keys
      end

      def self.mappings
        @mappings
      end

      def self.standardized_fields
        @standardized_fields
      end

      def initialize data = {}
        initial_id = data.fetch(:id) { 0 }

        if initial_id > 0
          self.class.mappings[initial_id].each do |key, value|
            next if key == value

            define_singleton_method key do
              send value
            end

            define_singleton_method "#{key}=" do |*args|
              send "#{value}=", *args
            end
          end
        end

        data.each do |key, value|
          send "#{key}=", value
        end
      end

      def data
        raise(Infuser::ArgumentError, 'Cannot be called if item has no ID') if id.nil?
        self.class.mappings[id].each_with_object({}) do |(key, value), hash|
          hash[key] = send(value)
        end
      end

      def attributes
        raise(Infuser::ArgumentError, 'Cannot be called if item has no ID') if id.nil?
        self.class.mappings[id].each_with_object({}) do |(key, value), hash|
          hash[value] = send(value)
        end
      end

    end
  end
end