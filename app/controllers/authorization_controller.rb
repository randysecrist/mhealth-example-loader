class AuthorizationController < ApplicationController
  def new
  end

  def update
    if !auth = request.env['omniauth.auth']
      return redirect_to root_path
    end

    session[:mhealth_token] = auth['credentials']['token']
    session[:mhealth_auth] = auth

    redirect_to new_sample_path
  end
end
