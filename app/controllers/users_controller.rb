class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "Registration successful!"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "Update successful!"
    else
      render :edit
    end

  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

private
  def sort_column
    params[:sort] || "lastname"
  end

  def sort_direction
     params[:direction] || "asc"
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation )
  end


end