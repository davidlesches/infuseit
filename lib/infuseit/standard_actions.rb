module Infuseit
  module StandardActions

    module ClassMethods

      cattr_accessor :schema, :collection_names
      self.schema = []
      self.collection_names = []

      def define_schema *args
        self.schema = *args
        attr_accessor *args
      end

      def define_collection type
        type = type.to_s.underscore
        self.collection_names << type

        define_method type.to_s.underscore.pluralize do
          collections[type]
        end
      end

      def find id
        item = new
        item.instance_variable_set(:@id, id)
        item.populate
      end

      def find_by hash
        hash.map do |key, value|
          response = get("#{service_name}.findBy#{key.classify}", value, 'Id')
          response.map { |contact| find(contact.Id) }
        end.flatten.uniq
      end

      def create data
        new(data).save
      end

      def service_name
        "#{name.split('::').last.underscore}_service"
      end

    end

    def self.included base
      base.send :extend, ClassMethods
    end

    attr_reader :id, :collections

    def initialize data = {}
      data.each do |key, value|
        send("#{key}=", value)
      end

      @collections = self.class.collection_names.each_with_object({}) do |name, hash|
        proxy = Infuseit::CollectionProxy.new(name)
        hash[name] = proxy
      end

      return self
    end

    def data
      data = self.class.schema.dup.each_with_object({}) { |key, hash| hash[key] = send(key) }
      collections.each do |name, proxy|
        data.merge!(proxy.to_hash)
      end
      camelize_hash(data)
    end

    def new_record?
      id.nil?
    end

    def persisted?
      !new_record?
    end

    def save options = {}
      new_record? ? add(options) : update(options)
      return self
    end

    def populate
      response = get("#{service_name}.load", id, fieldset)
      response.each do |key, value|
        send("#{key.underscore}=", value) if respond_to?(key.underscore.to_sym)
      end

      collections.each do |name, proxy|
        proxy.parse(response)
      end

      return self
    end

    def fieldset
      self.class.schema.dup.map { |f| f.to_s.classify }
    end

    def service_name
      self.class.service_name
    end


    private

    def add options = {}
      get("#{service_name}.add", data)
    end

    def update options = {}
      get("#{service_name}.update", id, data)
    end

  end
end