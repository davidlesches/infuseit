require 'rest_client'
require 'base64'
require 'json'

module Infuser
  class TokenRefresher

    attr_reader :refresh_token

    def initialize refresh_token
      @refresh_token = refresh_token
    end

    def refresh
      resource = RestClient::Resource.new(endpoint, Infuser::Configuration.api_key, Infuser::Configuration.api_secret)
      JSON.parse resource.post(params)
    end


    private

    def endpoint
      'https://api.infusionsoft.com/token'
    end

    def grant_type
      'refresh_token'
    end

    def params
      { grant_type: grant_type, refresh_token: refresh_token }
    end

  end
end