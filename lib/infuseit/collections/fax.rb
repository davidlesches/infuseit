module Infuseit
  module Collections
    class Fax < Base

      STANDARDIZED_FIELDS = [ :number, :type ]

      def self.mappings
        (1..2).each_with_object({}) do |i, hash|
          hash[i] = {
            "fax#{i}".to_sym      => :number,
            "fax#{i}_type".to_sym => :type,
          }
        end
      end

      attr_accessor :id
      attr_accessor *STANDARDIZED_FIELDS

    end
  end
end