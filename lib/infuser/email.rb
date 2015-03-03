module Infuser
  class Email < Infuser::Collections::Base

    define_mappings({
      1 => { :email => :email },
      2 => { :email_address2 => :email },
      3 => { :email_address3 => :email }
    })

  end
end