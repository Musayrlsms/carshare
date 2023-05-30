json.extract! brand, :id, :name, :logo, :created_at, :updated_at
json.url brand_url(brand, format: :json)
json.logo url_for(brand.logo)
