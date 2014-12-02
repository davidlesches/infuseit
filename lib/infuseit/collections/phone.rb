module Infuseit
  module Collections
    class Phone < Base

      STANDARDIZED_FIELDS = [ :number, :extension, :type ]

      def self.mappings
        (1..5).each_with_object({}) do |i, hash|
          hash[i] = {
            "phone#{i}".to_sym      => :number,
            "phone#{i}_ext".to_sym  => :extension,
            "phone#{i}_type".to_sym => :type,
          }
        end
      end

      attr_accessor :id
      attr_accessor *STANDARDIZED_FIELDS

    end
  end
end