class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :title, :authorized?

  def title
    return 'mHealth Example Loader' if @title.blank?

    "#{@title} - mHealth Example Loader"
  end

  def authorized?
    !(session[:mhealth_token].blank?)
  end

  def api_client
    return @api_client if defined? @api_client
    raise "No token" unless authorized?

    @api_client = self.class.api_client_for(session[:mhealth_token])
  end

  def self.api_client_for(token)
    Faraday.new url: 'https://api.demo.mhp.sl.attcompute.com/', ssl: {verify: false} do |builder|
      builder.use Faraday::Request::Authorization, 'OAuth', token
      builder.adapter :net_http
    end
  end
end
