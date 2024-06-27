class User < ApplicationRecord
    has_secure_password

    has_one :buyer, dependent: :destroy
    has_one :seller, dependent: :destroy

    after_create :create_buyer

    validates :email, presence: true, uniqueness: true
end
