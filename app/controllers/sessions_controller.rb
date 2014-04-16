class SessionsController < ApplicationController
  # http://stackoverflow.com/questions/6150388/passing-parameters-from-submit-tag
  # added the following line to avoid getting 
  # ActionController::InvalidAuthenticityToken errors
  skip_before_action :verify_authenticity_token

  def new
    if current_user
      flash[:alert] = "You are already signed in as #{current_user.firstname} #{current_user.lastname}!"
    else
    end
  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.firstname}!"
      redirect_to (session[:intended_url] || tips_path)
      session[:intended_url] = nil
   else
      if user
        flash.now[:alert] = "Invalid email/password!"
      end
      render :new
    end
  end

  def destroy
    uzr = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    redirect_to tips_path, notice: "Signed out successfully!"
  end
end
