class UsersController < ApplicationController
  before_action :require_signin, except: [:new, :create, :index]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy ]

  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Registration successful!"
    else
      render :new
    end
  end

  def show
    if current_user_or_admin?
      @user = User.find(params[:id])
    else
       redirect_to tips_path, notice: "Login required to access your user page!"
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Update successful!"
    else
      render :edit
    end

  end

  def destroy
    name = "#{@user.firstname} #{@user.lastname}"
    @user.destroy
    session[:user_id] = nil
    redirect_to users_path, alert: "#{name} was successfully deleted!"
  end

private
  def require_correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      redirect_to root_url
    end
  end

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
