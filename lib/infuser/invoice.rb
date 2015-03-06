module Infuser
  class Invoice < Infuser::Models::Base

    define_schema :affiliate_id, :contact_id, :credit_status, :date_created, :description, :invoice_total,
      :invoice_type, :job_id, :lead_affiliate_id, :pay_plan_status, :pay_status, :product_sold,
      :promo_code, :refund_status, :synced, :total_due, :total_paid

    belongs_to :contact

    has_many :invoice_items

    def add_item *data
      # Add in specific order:
      # product_id
      # type (UNKNOWN = 0, SHIPPING = 1, TAX = 2, SERVICE = 3, PRODUCT = 4, UPSELL = 5, FINANCECHARGE = 6, SPECIAL = 7)
      # price, quantity, description, notes
      client.get("InvoiceService.addOrderItem", id, *data)
    end

  end
end