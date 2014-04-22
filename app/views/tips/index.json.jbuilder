json.array!(@tips) do |tip|
  json.extract! tip, :id, :source, :rubytype, :subject, :category, :tip, :applies_to, :email, :posted, :xmail, :user_id
  json.url tip_url(tip, format: :json)
end
