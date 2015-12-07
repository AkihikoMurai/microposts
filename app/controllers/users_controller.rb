class UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update]
  before_action :user_check, only:[:edit, :update]

  def show
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_check
    if current_user!=@user#current_userが@userと違ったら
      #TOPへリダイレクト
      redirect_to root_path
    end
    #redirect_to root_path unless current_user == @user
  end
end