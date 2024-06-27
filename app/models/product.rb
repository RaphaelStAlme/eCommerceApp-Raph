class Product < ApplicationRecord
  belongs_to :seller
  has_many :orders

  validates :name, :description, :price, :stock, presence: true
end
