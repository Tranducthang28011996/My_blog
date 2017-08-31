class FollowsController < ApplicationController
  before_action :load_user

  def create
    current_user.follow @user
    render json: {
      form_follow: render_to_string(partial: "users/follow_form", locals: {user: @user})
    }
  end


  def destroy
    current_user.unfollow @user
    render json: {
      form_follow: render_to_string(partial: "users/follow_form", locals: {user: @user})
    }
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      redirect_to root_path
    end
  end
end
