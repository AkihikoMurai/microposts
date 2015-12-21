class UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update,:followings,:followers]
  before_action :user_check, only:[:edit, :update]

  def followings
    @users = @user.following_users
    #viewを表示　=> デフォルトのテンプレートファイルを持っている
  end
 
  def followers
    @users = @user.follower_users
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page]).per(10).order(created_at: :desc)
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
  
  def update
    if @user.update(user_params)
       redirect_to user_path , notice: '編集しました'
    else
      render 'edit'
    end
  end  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :location)
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
