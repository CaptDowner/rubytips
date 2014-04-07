json.array!(@tips) do |tip|
  json.extract! tip, :id, :source, :rubytype, :subject, :category, :tip, :applies_to, :email, :posted, :firstname, :lastname, :xmail
  json.url tip_url(tip, format: :json)
end
