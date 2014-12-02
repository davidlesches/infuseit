require 'active_support/core_ext/string/inflections'
require 'infuseit/configuration'
require 'infuseit/exception_handler'
require 'infuseit/exceptions'


require 'infuseit/base'
require 'infuseit/contact'

require 'infuseit/collection'
require 'infuseit/address'
require 'infuseit/phone'
require 'infuseit/fax'
require 'infuseit/email'
require 'infuseit/collection_proxy'

module Infuseit

  def self.logger
    Infuseit::Configuration.logger
  end

end

