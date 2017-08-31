class SessionsController < ApplicationController
  def create
    user = User.find_by email: params[:session][:email].downcase

    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      flash[:success] = t "login.create_success"
      redirect_to user
    else
      flash.now[:danger] = t "login.create_danger"
      render :new
    end
  end

  def destroy
    forget current_user
    session[:user_id] = nil
    render :new
  end
end
