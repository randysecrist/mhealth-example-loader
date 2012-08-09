class AuthorizationController < ApplicationController
  def create
    if !auth = request.env['omniauth.auth']
      return redirect_to root_path
    end

    session[:mhealth_token] = auth['credentials']['token']
    session[:mhealth_auth] = auth
  end
end
