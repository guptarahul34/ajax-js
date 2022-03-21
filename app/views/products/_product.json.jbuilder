json.extract! product, :id, :name, :product_image, :created_at, :updated_at
json.url product_url(product, format: :json)
