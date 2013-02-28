Rails.application.config.middleware.use OmniAuth::Builder do
  provider(:mhealth, ENV['MHEALTH_KEY'], ENV['MHEALTH_SECRET'], 
           client_options: {
            site: 'https://demo.mhp.sl.attcompute.com/'
            },
            api_site: 'https://api.demo.mhp.sl.attcompute.com/',
           setup:(lambda do |env|
    request = Rack::Request.new env
    scopes = %w{/read/health/user}
    if request.params['app']
      request.params['app'].each do |a|
        scopes << "/read/health/data/#{a}" << "/admin/health/source/#{a}"
      end
    end

    env['omniauth.strategy'].options[:scope] = scopes.join ' '
  end))
end
