module Infuseit
  module Collections
    class Address < Base

      STANDARDIZED_FIELDS = [ :street_address, :street_address2, :address_type, :city, :state, :country, :postal_code, :zip ]

      def self.mappings
        {
          1 => {
            :street_address1 => :street_address,
            :street_address2 => :street_address2,
            :address1_type   => :address_type,
            :city            => :city,
            :state           => :state,
            :country         => :country,
            :postal_code     => :postal_code,
            :zip_four1       => :zip
          },
          2 => {
            :address2_street1 => :street_address,
            :address2_street2 => :street_address2,
            :address2_type    => :address_type,
            :city2            => :city,
            :state2           => :state,
            :country2         => :country,
            :postal_code2     => :postal_code,
            :zip_four2        => :zip
          },
          3 => {
            :address3_street1 => :street_address,
            :address3_street2 => :street_address2,
            :address3_type    => :address_type,
            :city3            => :city,
            :state3           => :state,
            :country3         => :country,
            :postal_code3     => :postal_code,
            :zip_four3        => :zip
          }
        }
      end

      attr_accessor :id
      attr_accessor *STANDARDIZED_FIELDS

    end
  end
end