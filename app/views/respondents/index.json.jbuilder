json.array!(@respondents) do |respondent|
  json.extract! respondent, :id, :gender, :height, :weight
  json.url respondent_url(respondent, format: :json)
end
