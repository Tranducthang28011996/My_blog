class CommentsController < ApplicationController
  def create
    post = Micropost.find_by id: params[:micropost_id]

    if post && current_user
      @comment = post.comments.build message_params
      @comment.user_id = current_user.id
      @comment.save
      render json: {
        content: @comment.content,
        post_id: post.id,
        user_name: current_user.name
    }
    end
  end

  private

  def message_params
    params.require(:comment).permit :content
  end
end
