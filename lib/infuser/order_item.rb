module Infuser
  class OrderItem < Infuser::Models::Base

    define_schema :item_description, :item_name, :item_type, :notes, :order_id,
      :product_id, :CPU, :PPU, :qty

    has_many :invoice_items

  end
end
