class Order < ApplicationRecord
  belongs_to :product
  belongs_to :buyer

  validates :quantity, :total_price, presence: true
end