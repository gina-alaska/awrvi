json.array!(@choices) do |choice|
  json.extract! choice, :id, :category_id, :index, :description
  json.url choice_url(choice, format: :json)
end
