class SessionsController < ApplicationController

  def index
    if current_user
      @groups = Meetup::Groups.new(current_user.uid, session[:token]).all
    end
  end

  def create
    set_current_user_and_token
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

  private
  def auth
    request.env["omniauth.auth"]
  end

  def set_current_user_and_token
    session[:user_id] = User.find_or_create_with_omniauth(auth).id
    session[:token] = auth["credentials"]["token"]
  end
end
