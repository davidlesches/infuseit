module Infuser
  class Invoice < Infuser::Models::Base

    define_schema :affiliate_id, :contact_id, :credit_status, :date_created, :description, :invoice_total,
      :invoice_type, :job_id, :lead_affiliate_id, :pay_plan_status, :pay_status, :product_sold,
      :promo_code, :refund_status, :synced, :total_due, :total_paid

    belongs_to :contact

    has_many :invoice_items

  end
end