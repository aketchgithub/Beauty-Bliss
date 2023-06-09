class User < ApplicationRecord
    has_secure_password
    has_many :orders 
    has_many :products, dependent: :destroy

    validates :username, presence: true, uniqueness: true
end
