class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :find_article, except: [:new, :create]

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:notice] = "Article has been created!"
      redirect_to @article
    else
      flash.now[:alert] = "Article could not be created"
      render :new
    end
  end

  def edit
    authorize @article
  end

  def update
    authorize @article
    if @article.update(article_params)
      flash[:notice] = "Article has been updated"
      redirect_to @article
    else
      flash.now[:alert] = "Article could not be updated"
      render :edit
    end
  end

  def destroy
    authorize @article
    @article.destroy
    flash[:notice] = "Article has been deleted"
    redirect_to root_path 
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end

    def find_article
      @article = Article.find(params[:id])
    end
end
