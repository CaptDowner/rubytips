class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.firstname}!"
      redirect_to user
    else
      flash.now[:alert] = "Invalid email/password!"
      render :new
    end
  end
end
