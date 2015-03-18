json.array!(@users) do |user|
  json.extract! user, :id, :pseudo, :password, :firstname, :name, :email, :age
  json.url user_url(user, format: :json)
end
