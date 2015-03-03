module Infuser
  class Client

    TABLES = %w( contact company invoices invoice_items )
    attr_reader *TABLES.map(&:pluralize)
    attr_reader :access_token

    def initialize access_token
      @access_token = access_token || raise(Infuser::ArgumentError, 'You must specify an access token.')
      setup_associations
      self
    end

    def inspect
      "#<#{self.class.name} access_token: #{access_token}>"
    end


    private

    def setup_associations
      TABLES.each do |assoc|
        instance_variable_set "@#{assoc.pluralize}".to_sym, Infuser::Tables.const_get(assoc.classify).new(__client__)
      end
    end

    def __client__
      @__client__ ||= Infuser::Requester.new(access_token)
    end

  end
end