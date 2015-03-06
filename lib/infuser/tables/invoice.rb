module Infuser
  module Tables
    class Invoice < Base

      def build data
        raise(NotImplementedError, 'You must use #create method for invoices. Infusionsoft is a delight :)')
      end

      def create *data
        # Add in specific order:
        # contact_id, description, date, then:
        # lead_affiliate_id 0 should be used if none
        # sale_affiliate_id 0 should be used if none
        id = client.get("InvoiceService.createBlankOrder", *data)
        find(id)
      end

    end
  end
end