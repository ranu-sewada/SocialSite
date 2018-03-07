class PostsController < ApplicationController
  # before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    # @posts = Post.all

     # render 'list_of_posts'
       # @posts = user.posts.where(:user_id => current_user.id)

  end

  def list_of_posts
    @c_user = User.find(params[:id])
    @posts = @c_user.posts.page(params[:page]).per(5)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    # @post = Post.new
    @post = current_user.posts.new

    # @post.user = current_user
  end

  # GET /posts/1/edit
  def edit
   @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)
    # @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to list_of_posts_post_path(@post.user), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    # @post.user = current_user
      if @post.update_attributes(post_update_params)

        redirect_to list_of_posts_post_path(current_user), notice: 'Post was successfully created.'
        # format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        # format.json { render :show, status: :ok, location: @post }
      else
        redirect_to root_url
        # format.html { render :edit }
        # format.json { render json: @post.errors, status: :unprocessable_entity }
      end

  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to list_of_posts_post_path(current_user)
    # respond_to do |format|
    #   format.html { , notice: 'Post was successfully destroyed.' }
    #   format.json { head :no_content }
    # end

  end

  def like
   @post = Post.find(params[:id])

   @status = Status.new(post_id:  @post.id, user_id: current_user.id, like: true)
   if @status.save
      redirect_to(list_of_posts_post_path(@post.user))
    else
      flash[:notice] = "There is problem to like a post"
      redirect_to(@post)
   end
  end



  def dislike
    @post = Post.find(params[:id])
     @dis = Status.all.where(:post_id => @post.id, :user_id => current_user.id, :like => true).first
    # @dis = current_user.statuses.where(:post_id => @post_id).first
    if !@dis.nil?
      if @dis.destroy
        flash[:notice] = "You have disliked post"
        redirect_to(list_of_posts_post_path(@post.user))
      else
        redirect_to(@post)
      end
    else

    end
  end

  def new_comment
    @comment = Comment.new
    @current_post = Post.find(params[:id])
  end

  def create_new_comment
    @com = current_user.comments.new(comment_params)
    if @com.save
      redirect_to(show_all_comments_post_path)
    end
  end

  def show_all_comments
    # @comments = Comment.all
    @comment = Comment.new

    @current_post = Post.find(params[:id])
    @comments = @current_post.comments
     @post_content = @current_post.content

    if @current_post.nil?
      puts "---------------------------------------------------"

    end
     puts "++++++++++++++++++++++++++++++++++++++++++++=++++"
     puts @current_post.content
  end


  private
    # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:content, :user_id)
  end

 def post_update_params
  params.require(:post).permit(:content)
 end

  def comment_params
  params.require(:comment).permit(:content, :user_id, :post_id)
end


end
