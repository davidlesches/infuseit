require 'infuseit/helpers/mattr'
require 'infuseit/logger'
require 'infuseit/version'

module Infuseit
  module Configuration

    OPTION_KEYS = [ :api_url, :api_key, :user_agent, :logger ]

    class << self

      mattr_accessor *OPTION_KEYS
      self.user_agent = "Infuseit-#{VERSION} (RubyGem)"
      self.logger     = Infuseit::Logger.new

      # Convenience method to allow configuration options to be set in a block
      def configure
        yield self
      end

    end

  end
end
