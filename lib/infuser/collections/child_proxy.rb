module Infuser
  module Collections
    class ChildProxy

      # For has_many, eg contact has_many invoices

      include Enumerable

      attr_reader :parent, :child_klass

      def initialize parent, child_klass
        @parent      = parent
        @child_klass = child_klass
      end

      def set
        @set ||= table.find_by(parent_klass_field => parent.id)
      end

      def remove item
        item.destroy
        set.delete item
      end

      def << item
        item.save if item.new_record?
        item.send(:update, { parent_klass_field => parent.id })
        set << item
      end

      def each &block
        set.each(&block)
      end

      def find id
        set.find { |item| item.id == id }
      end


      private

      def parent_klass_field
        "#{parent.klass_name.classify}ID"
      end

      def table
        Infuser::Tables.const_get(child_klass.to_s.classify).new(client)
      end

      def client
        # an unhappy hack
        parent.send(:client)
      end

    end
  end
end