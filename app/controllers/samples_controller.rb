class SamplesController < ApplicationController
  def new
    redirect_to new_authorization_path unless authorized?
  end
end
