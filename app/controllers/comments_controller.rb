class CommentsController < ApplicationController
  def new

  end

  def create


     # @coStatus.new(post_id:  @post.id, user_id: current_user.id, like: true)

  end

  def index
    @comments = Comment.all
    @current_post = Post.find(params[:id])
  end

  private
   def comment_params
      params.require(:comment).permit(:content, :user_id, :post_id)
    end

end
