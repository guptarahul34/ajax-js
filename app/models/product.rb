class Product < ApplicationRecord
    validates :name, :product_image, presence: true
    has_one_attached :product_image
    has_many_attached :images
end
