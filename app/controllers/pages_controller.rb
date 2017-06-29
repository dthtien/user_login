class PagesController < ApplicationController
  def home
    @posts = Post.includes(:comments).includes(:user).all
    @post = Post.new
  end
end
