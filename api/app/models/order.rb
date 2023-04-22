class Order < ApplicationRecord
    belongs_to :user
    has_many :order_items
    has_many :products, through: :order_items

    def total_price
        order_items.inject(0) { |sum, item| sum + item.price }
    end

    


end
