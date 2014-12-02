require 'active_support/core_ext/string/inflections'
require 'infuseit/configuration'
require 'infuseit/exception_handler'
require 'infuseit/exceptions'
require 'infuseit/client'
require 'infuseit/collections'

module Infuseit

  def self.logger
    Infuseit::Configuration.logger
  end

end

