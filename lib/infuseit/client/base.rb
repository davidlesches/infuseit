require 'xmlrpc/client'
require 'infuseit/helpers/hashie'

module Infuseit
  module Client
    class Base
      include Infuseit::Helpers::Hashie


      private

      def connection service_call, *args
        retry? ? retrying! : raise(InfuseitError, 'Call failed and retries exhausted.')

        begin
          logger.info "CALL:#{service_call} at:#{Time.now} args:#{args.inspect}"
          result = client.call(service_call, options.api_key, *args)
          connection(service_call, *args) if result.nil?
        rescue Timeout::Error => timeout
          connection(service_call, *args)
        rescue XMLRPC::FaultException => xmlrpc_error
          # Catch all XMLRPC exceptions and rethrow specific exceptions for each type of xmlrpc fault code
          Infuseit::ExceptionHandler.new(xmlrpc_error)
        end # Purposefully not catching other exceptions so that they can be handled up the stack

        logger.info "RESULT: #{result.inspect}"
        return result
      end

      def get method, service_call, *args
        connection service_call, *args
      end

      def retry?
        retry_count <= 5
      end

      def retrying!
        retry_count += 1
      end

      def retry_count
        @retry_count ||= 0
      end

      def options
        Infuseit::Configuration
      end

      def logger
        options.logger
      end

      def client
        @client ||= begin
          client = XMLRPC::Client.new3({
            'host'    => options.api_url,
            'path'    => "/api/xmlrpc",
            'port'    => 443,
            'use_ssl' => true
          })
          client.http_header_extra = { 'User-Agent' => options.user_agent }
          client
        end
      end

    end
  end
end