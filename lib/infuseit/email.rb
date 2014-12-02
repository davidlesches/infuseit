module Infuseit
  class Email < Collection

    STANDARDIZED_FIELDS = [ :email ]

    def self.mappings
      {
        1 => { :email => :email },
        2 => { :email_address2 => :email },
        3 => { :email_address3 => :email }
      }
    end

    attr_accessor :id
    attr_accessor *STANDARDIZED_FIELDS

  end
end