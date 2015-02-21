json.array!(@predictions) do |prediction|
  json.extract! prediction, :id, :height, :weight
  json.url prediction_url(prediction, format: :json)
end
