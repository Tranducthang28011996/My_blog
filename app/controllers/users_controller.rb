class UsersController < ApplicationController

  def new
    @user =  User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = t "signup.create_success"
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
    @microposts = @user.microposts.created_sort.
    paginate page: params[:page], per_page: Settings.paginate
  end

  def update
    @user = User.find_by id: params[:id]
    if @user.update avatar: params[:user][:avatar]
      redirect_to @user
    else

    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def params_avatar
    params.require(:user).permit :avatar
  end
end
