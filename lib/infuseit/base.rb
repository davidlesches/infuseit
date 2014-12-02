require 'infuseit/helpers/hashie'
require 'infuseit/connection'
require 'infuseit/standard_actions'

module Infuseit
  class Base

    include Connection
    include StandardActions
    include Infuseit::Helpers::Hashie


    private

    def logger
      options.logger
    end

  end
end