json.extract! user, :id, :email, :last_transition, :provider, :uid, :created_at, :updated_at
json.url user_url(user, format: :json)