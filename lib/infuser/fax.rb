module Infuser
  class Fax < Infuser::Collections::Base

    define_mappings( (1..2).each_with_object({}) do |i, hash|
      hash[i] = {
        "fax#{i}".to_sym      => :number,
        "fax#{i}_type".to_sym => :type,
      }
    end )

  end
end