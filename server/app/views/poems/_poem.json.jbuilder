json.extract! poem, :id, :title, :context, :created_at, :updated_at
json.url poem_url(poem, format: :json)
