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
end
