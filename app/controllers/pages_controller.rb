class PagesController < ApplicationController
  def home
    @posts = Post.includes(:comments).includes(:user).all
    @post = Post.new
    @post.images.build
  end
end
