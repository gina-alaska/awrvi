json.array!(@indices) do |index|
  json.extract! index, :id, :published_at, :awrvi_version, :awrvi_index, :rejected_at, :rejected_reason
  json.url index_url(index, format: :json)
end
