class SessionsController < ApplicationController
  
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_email(auth["info"]["email"]) 
    session[:user_id] = user.id
    path = user.nickname || user.uid
    redirect_to '/users/' + path
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
