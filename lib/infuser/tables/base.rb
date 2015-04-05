module Infuser
  module Tables
    class Base
      include Infuser::Helpers::Hashie

      PAGINATION = 1000

      def initialize client
        @client = client
        self
      end

      def build data
        item = model_klass.new(data)
        item.instance_variable_set(:@client, client)
        item
      end

      def create data
        build(data).save
      end

      def find id
        item = model_klass.new
        item.instance_variable_set(:@id, id)
        item.instance_variable_set(:@client, client)
        item.load
      end

      def find_by hash
        page    = 0
        count   = PAGINATION
        records = []

        begin
          response = client.get("DataService.query", klass_name, PAGINATION, page, camelize_hash(hash, klass_name), (model_klass.fieldset.dup << 'Id'))
          page += 1
          count = response.count

          records << response.map do |hash|
            item = model_klass.new
            item.instance_variable_set(:@client, client)
            item.instance_variable_set(:@id, hash['Id'])
            item.populate(hash.reject { |k, v| k == 'Id'})
            item
          end
        end while count == PAGINATION

        records.flatten
      end

      def all
        find_by id: '%'
      end


      private

      def klass_name
        self.class.name.split('::').last
      end

      def service_name
        "#{klass_name.underscore}_service".classify
      end

      def model_klass
        Infuser.const_get(klass_name)
      end

      def client
        @client || raise(Infuser::Error, "Do not use the #{self.class.name} class directly. Use the Infuser::Client instead.")
      end

    end
  end
end