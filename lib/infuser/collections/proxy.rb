module Infuser
  module Collections
    class Proxy

      include Enumerable

      attr_reader :klass

      def initialize klass
        @klass = Infuser.const_get(klass.to_s.classify)
      end

      def parse dump
        dump.each do |key, value|
          if id = klass.inverted_mappings[key.underscore.to_sym]
            find_or_create(id).send("#{key.underscore}=", value)
          end
        end
      end

      def schema
        klass.schema
      end

      def set
        @set ||= []
      end

      def remove item
        set.delete item
      end

      def << item
        if set.size == klass.mappings.keys.max
          raise(Infuser::ArgumentError, "The collection is full, you can not add another item.")
        elsif item.class.name != klass.name
          raise(Infuser::ArgumentError, "The item you are adding does not belong in this collection.")
        else
          item.id = ( (1..klass.mappings.keys.max).to_a - set.map(&:id) ).sort.first
          set << item
        end
      end

      def each &block
        set.each(&block)
      end

      def find id
        set.find { |item| item.id == id }
      end

      def find_or_create id
        find(id) || begin
          item = klass.new(id: id)
          set << item
          item
        end
      end

      def data
        set.each_with_object({}) do |item, hash|
          item.data.each do |key, value|
            hash[key] = value
          end
        end
      end

    end
  end
end