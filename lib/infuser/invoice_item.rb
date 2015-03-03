module Infuser
  class InvoiceItem < Infuser::Models::Base

    define_schema :commission_status, :date_created, :description, :discount, :invoice_amt,
      :invoice_id, :order_item_id

    belongs_to :invoice

  end
end