module Infuser
  class Company < Infuser::Models::Base

    define_schema :test

    define_collection :email
    define_collection :phone
    define_collection :fax
    define_collection :address

  end
end