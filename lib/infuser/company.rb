module Infuser
  class Company < Infuser::Models::Base

    define_collection :email
    define_collection :phone
    define_collection :fax
    define_collection :address

    define_schema :company, :website

  end
end