class Product < ApplicationRecord
    validates :name, presence: {message: " must be available."}
    has_one_attached :product_image
    has_many_attached :images

    # validates :product_image, content_type: { in: :pdf, message: " is not a pdf."}
    validates :product_image, attached: true, content_type: ["image/jpeg","image/png"], dimension: { width: 200, height: 200 ,message: " is not in between 200 and 200" }
    validates :images, attached: true, limit: {min: 1, max: 2, message: "min 1 and max 2"}, dimension: {  width: {min: 200, max: 1000}, height: { min:300, max: 400 }, message: " min width is 200 and maximum width is 1000" }
end
