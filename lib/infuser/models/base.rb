module Infuser
  module Models
    class Base
      include Infuser::Helpers::Hashie

      class << self

        def schema
          @schema || []
        end

        def collection_names
          @collection_names || []
        end

        def define_schema *cols
          @schema = *cols
          attr_accessor *cols
        end

        def define_collection type
          type = type.to_s.underscore
          @collection_names ||= []
          @collection_names << type

          define_method type.to_s.underscore.pluralize do
            collections[type]
          end
        end

        def fieldset
          core = schema.dup
          coll = collection_names.map { |name| Infuser.const_get(name.classify).schema.dup }
          (core + coll).flatten.compact.map { |f| f.to_s.split('_').map(&:titleize).join }
        end

        def klass_name
          name.split('::').last
        end

        def service_name
          "#{klass_name.underscore}_service".classify
        end

      end

      attr_reader :id, :collections

      def initialize data = {}
        data.each do |key, value|
          send("#{key}=", value)
        end

        @collections = self.class.collection_names.each_with_object({}) do |name, hash|
          hash[name] = Infuser::Collections::Proxy.new(name)
        end

        return self
      end

      def inspect
        "#<#{self.class.name} #{attributes.map { |k, v| "#{k}: #{v || 'nil'}" }.join(', ')}>"
      end

      def attributes
        data = self.class.schema.dup.each_with_object({}) { |key, hash| hash[key] = send(key) }
        collections.each do |name, proxy|
          data[name] = proxy.map(&:attributes)
        end
        data
      end

      def data
        data = self.class.schema.dup.each_with_object({}) { |key, hash| hash[key] = send(key) }
        collections.each do |name, proxy|
          data.merge!(proxy.data)
        end
        camelize_hash(data).select { |k, v| !v.nil? }
      end

      def new_record?
        id.nil?
      end

      def persisted?
        !new_record?
      end

      def save
        new_record? ? add : update
        return self
      end

      def destroy
        client.get("DataService.delete", klass_name, id)
      end

      def load
        populate client.get("#{service_name}.load", id, fieldset)
      end

      def populate hash
        hash.each do |key, value|
          send("#{key.underscore}=", value) if respond_to?(key.underscore.to_sym)
        end

        collections.each do |name, proxy|
          proxy.parse(hash)
        end

        return self
      end

      def fieldset
        self.class.fieldset
      end

      def klass_name
        self.class.klass_name
      end

      def service_name
        self.class.service_name
      end


      private

      def add options = {}
        client.get("#{service_name}.add", data)
      end

      def update options = {}
        client.get("#{service_name}.update", id, data)
      end

      def client
        @client || raise(Infuser::Error, "No client found. Do not use the #{klass_name} class directly. Use the Infuser::Client instead.")
      end

    end
  end
end