class CommentsController < ApplicationController
  # skip_before_filter :verify_authenticity_token
  # protect_from_forgery prepend: true, with: :exception
  before_action :authenticate_user!
  before_action :set_post, only: :create
  before_action :set_comment, only: [:edit, :update, :destroy]


  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment was successfully created.' }
        format.js
      else
        format.html { redirect_to @post, alert: 'Comment was not created.' }
      end
    end
  end

  def edit
    authorize @comment
  end

  def update
    authorize @comment
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.post, notice: 'Comment was successfully updated.' }
        format.js
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize @comment
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Comment was successfully destroyed.' }
    end
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content, :user_id, :article_id, image_attributes: [:image_upload])
    end
end
