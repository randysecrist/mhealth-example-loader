Rails.application.config.middleware.use OmniAuth::Builder do
  provider :mhealth, ENV['MHEALTH_KEY'], ENV['MHEALTH_SECRET']
end
