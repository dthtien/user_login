class PagesController < ApplicationController
  
  def home
    @posts = Post.includes(:comments).includes(:user).page(params[:page])
    @post = Post.new
    @post.images.build

    respond_to do |format|
      format.html
      format.js
    end
  end
end
