module Infuser
  module Models
    class Base
      include Infuser::Helpers::Hashie

      INFUSIONSOFT_MAPPING = {}

      class << self

        def schema
          @schema || []
        end

        def collection_names
          @collection_names || []
        end

        def children_names
          @children_names || []
        end

        def define_schema *cols
          @schema = *cols
          attr_accessor *cols
        end

        def has_collection type
          type = type.to_s.underscore
          @collection_names ||= []
          @collection_names << type

          define_method type.to_s.underscore do
            collections[type]
          end
        end

        def has_many type
          type = type.to_s.underscore
          @children_names ||= []
          @children_names << type

          define_method type.to_s.underscore do
            children[type]
          end
        end

        def belongs_to type
          type = type.to_s.underscore

          define_method "#{type}=" do |arg|
            update_association(type, arg)
          end

          define_method "clear_#{type}" do
            clear_association(type)
          end

          define_method "#{type}" do
            fetch_association(type)
          end
        end

        def fieldset
          core = schema.dup
          coll = collection_names.map { |name| Infuser.const_get(name.classify).schema.dup }
          (core + coll).flatten.compact.map do |f|
            # don't use titlecase or upcase or fields like CompanyID turn into company
            f.to_s.split('_').map { |w| w[0] = w[0].upcase; w }.join
          end
        end

        def klass_name
          name.split('::').last
        end

        def service_name
          "#{klass_name.underscore}_service".classify
        end

      end

      attr_reader :id

      def initialize data = {}
        data.each do |key, value|
          send("#{key}=", value)
        end

        @collections = self.class.collection_names.each_with_object({}) do |name, hash|
          hash[name] = Infuser::Collections::Proxy.new(name)
        end

        @children = self.class.children_names.each_with_object({}) do |name, hash|
          hash[name] = Infuser::Collections::ChildProxy.new(self, name)
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
        populate client.get("DataService.load", klass_name, id, fieldset)
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

      def model_klass
        Infuser.const_get(klass_name)
      end

      def service_name
        self.class.service_name
      end


      private

      def add
        @id = client.get("DataService.add", klass_name, data)
        self
      end

      def update fields = data
        client.get("DataService.update", klass_name, id, fields)
      end

      def client
        @client || raise(Infuser::Error, "No client found. Do not use the #{klass_name} class directly. Use the Infuser::Client instead.")
      end

      def collections
        @collections
      end

      def children
        @children
      end

      def update_association type, item
        raise(Infuser::ArgumentError, "Item has not been saved yet and cannot be used as an association") if !item.id
        update({ "#{type.classify}ID" => item.id })
        true
      end

      def clear_association type
        raise NotImplementedError
      end

      def fetch_association type
        id_field = "#{type}_id"
        raise(Infuser::RecordNotFound) if send(id_field).nil?
        Infuser::Tables.const_get(type.classify).new(client).find send(id_field)
      end

    end
  end
end