class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: [:created]

  def index
    @microposts = Micropost.created_sort.
      paginate page: params[:page], per_page: Settings.paginate
    @micropost = current_user.microposts.build if logged_in?
  end

  def create
    @micropost = current_user.microposts.new micropost_params

    if @micropost.save
      flash[:success] = t "index.create_success"
      redirect_to root_url
    else
      flash[:danger] = t "index.create_danger"
      redirect_to root_url
    end
  end

  def destroy
    @micropost = Micropost.find params[:post_id]
    @micropost.destroy
  end

  private

  def micropost_params
    params.require(:micropost).permit :content
  end

end
