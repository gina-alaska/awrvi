json.array!(@communities) do |community|
  json.extract! community, :id, :name, :gnis_id, :census_id, :location
  json.url community_url(community, format: :json)
end
