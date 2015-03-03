module Infuser
  class Phone < Infuser::Collections::Base

    define_mappings( (1..5).each_with_object({}) do |i, hash|
      hash[i] = {
        "phone#{i}".to_sym      => :number,
        "phone#{i}_ext".to_sym  => :extension,
        "phone#{i}_type".to_sym => :type,
      }
    end )

  end
end