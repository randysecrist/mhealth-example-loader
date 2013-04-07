Rails.application.config.middleware.use OmniAuth::Builder do
  provider(:mhealth, ENV['MHEALTH_KEY'], ENV['MHEALTH_SECRET'], 
           client_options: {
            site: 'https://mhealth.dev.attcompute.com/',
            ssl: {verify: false}
            },
            api_site: 'https://api-mhealth.dev.attcompute.com/',
           setup:(lambda do |env|
    request = Rack::Request.new env
    scopes = %w{/read/health/user}
    apps = request.params['app'].reject {|x| x == ""} if request.params['app']
    if apps
      apps.each do |a|
        scopes << "/read/health/data/#{a}" << "/admin/health/source/#{a}"
      end
    end

    env['omniauth.strategy'].options[:scope] = scopes.join ' '
  end))
end
