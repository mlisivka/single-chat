Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vk, "5709947", "96wmPMdktj55QTxUBhay", scope: 'email'
  provider :facebook, ENV['FACEBOOK_KEY'],   ENV['FACEBOOK_SECRET'], scope: 'email', info_fields: 'email'
end