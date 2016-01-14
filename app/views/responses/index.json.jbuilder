json.array!(@responses) do |response|
  json.extract! response, :id, :awrvi_index, :awrvi_text, :raw_value
  json.url response_url(response, format: :json)
end
