module Infuser
  module Configuration

    OPTION_KEYS = [
      :api_key,
      :api_secret,
      :user_agent,
      :logger,
      :retry_count,
      :duplication_check
    ]

    class << self

      mattr_accessor *OPTION_KEYS

      self.user_agent        = "Infuser-#{VERSION} (RubyGem)"
      self.logger            = Infuser::Logger.new
      self.retry_count       = 5
      self.duplication_check = :email_and_name

      def configure
        yield self
      end

      def attributes
        OPTION_KEYS.each_with_object({}) { |key, hash| hash[key] = send(key) }
      end

    end

  end
end


