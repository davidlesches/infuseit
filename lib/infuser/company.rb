module Infuser
  class Company < Infuser::Models::Base

    define_schema :company, :website, :date_created, :last_updated

    has_collection :emails
    has_collection :phones
    has_collection :faxes
    has_collection :addresses

  end
end