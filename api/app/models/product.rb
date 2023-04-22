class Product < ApplicationRecord
    # belongs_to :category
    has_many :order_items
    has_many :orders, through: :order_items

    # custom method search to allow users to search for products by name;

    def self.search(query)
        where("name ILIKE ?", "%#{query}%")
    end

end
