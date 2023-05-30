json.extract! car, :id, :details, :model_id, :brand_id, :user_id, :distance, :max_luggage, :seat_count, :case_type, :images, :created_at, :updated_at
json.url car_url(car, format: :json)
json.images do
  json.array!(car.images) do |image|
    json.id image.id
    json.url url_for(image)
  end
end
