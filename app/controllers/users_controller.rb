class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  #respond_to :json, :html

  def index
    @users = Visitor.all
  end

  def show
  end

  def new
    @user = Visitor.new
  end

  def edit
  end

  def create
    @user = Visitor.new(user_params)
      if @user.save
        log_in @user
        flash[:success] = 'Account was successfully created.'
        redirect_to @user
      else
        render :new
      end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Account was successfully updated.'
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
      if @user.destroy
        flash[:success] = 'Account was successfully destroyed.'
        redirect_to root_url
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = Visitor.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = Visitor.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
