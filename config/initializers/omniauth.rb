Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vk, ENV['VK_KEY'], ENV['VK_SECRET'], scope: 'email'
  provider :facebook, ENV['FACEBOOK_KEY'],   ENV['FACEBOOK_SECRET'], scope: 'email', info_fields: 'email'
end