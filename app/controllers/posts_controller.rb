class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, only: %i[index edit destroy]

  before_action :check_if_belongs_to_user, only: %i[edit destroy]

  def index
    @posts = Post.where(user_id: current_user.id)
  end

  def feeds
    @feeds = Post.active.published
    @featured = Post.featured
  end

  def feed_show
    @feed = Post.find(params[:id])
    @author = User.find(@feed.user_id)
  end

  # GET /posts/1 or /posts/1.json
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id # set post user id to current user id

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :is_active, :is_featured, :published_date)
  end

  def check_if_belongs_to_user
    return if @post.belongs_to_user(current_user.id)

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Can't Edit Post that is not yours" }
    end
  end
end
