Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vk, "5709947", "96wmPMdktj55QTxUBhay", scope: 'email'
  provider :facebook, '328125600896746', '0d201ebff1a9e86b1c497098acd6c0aa', scope: 'email', info_fields: 'email'
end