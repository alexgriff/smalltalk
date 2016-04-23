class SessionsController < ApplicationController

  def new
  end

  def create
    binding.pry
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password]) 
      session[:user_id] = user.id
      redirect_to user_path(user), notice: "Logged In"
    else
      flash.now.alert = "Email or password is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged Out"
  end

end
