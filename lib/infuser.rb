require 'active_support/core_ext/string/inflections'
require 'infuser/helpers/mattr'
require 'infuser/helpers/hashie'
require 'infuser/version'

require 'infuser/logger'
require 'infuser/exceptions'
require 'infuser/configuration'

require 'infuser/collections/base'
require 'infuser/collections/proxy'
require 'infuser/collections/child_proxy'
require 'infuser/address'
require 'infuser/phone'
require 'infuser/fax'
require 'infuser/email'

require 'infuser/tables/base'
require 'infuser/tables/contact'
require 'infuser/tables/company'
require 'infuser/tables/invoice'
require 'infuser/tables/invoice_item'

require 'infuser/models/base'
require 'infuser/contact'
require 'infuser/company'
require 'infuser/invoice'
require 'infuser/invoice_item'

require 'infuser/requester'
require 'infuser/client'


module Infuser

  def self.logger
    Infuser::Configuration.logger
  end

end

# delete this
Infuser::Configuration.configure do |c|
  c.api_key = 'zyh7cwtt24exdxnmhd82ukta'
end