require 'infuseit/configuration'

module Infuseit
  class Base

    attr_accessor :retry_count
    attr_accessor *Configuration::VALID_OPTION_KEYS

    def initialize options = {}
      @retry_count = 0
      options = Infuseit.options.merge(options)
      Configuration::VALID_OPTION_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end


    private

    def connection(service_call, *args)
      client = XMLRPC::Client.new3({
        'host' => api_url,
        'path' => "/api/xmlrpc",
        'port' => 443,
        'use_ssl' => true
      })
      client.http_header_extra = {'User-Agent' => user_agent}
      begin
        api_logger.info "CALL: #{service_call} api_key:#{api_key} at:#{Time.now} args:#{args.inspect}"
        result = client.call("#{service_call}", api_key, *args)
        if result.nil?; ok_to_retry('nil response') end
      rescue Timeout::Error => timeout
        # Retry up to 5 times on a Timeout before raising it
        ok_to_retry(timeout) ? retry : raise
      rescue XMLRPC::FaultException => xmlrpc_error
        # Catch all XMLRPC exceptions and rethrow specific exceptions for each type of xmlrpc fault code
        Infuseit::ExceptionHandler.new(xmlrpc_error)
      end # Purposefully not catching other exceptions so that they can be handled up the stack

      api_logger.info "RESULT: #{result.inspect}"
      return result
    end

    def ok_to_retry(e)
      retry_count += 1
      if retry_count <= 5
        api_logger.warn "Retry: #{retry_count}"
        true
      else
        false
      end
    end

    def get method, service_call, *args
      connection service_call, *args
    end

  end
end