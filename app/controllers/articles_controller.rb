class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = user_signed_in? ? Article.sorted : Article.sorted.published
    @pagy, @articles = pagy(@articles)
  rescue Pagy::OverflowError
    # Redirect to page 1
    # redirect_to root_path(page: 1)
    # Retry but with correct page number, keeps page number
    params[:page] = 1
    retry
  end

  def show
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to root_path
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :published_at)
  end

  def set_article
    @article = user_signed_in? ? Article.find(params[:id]) : Article.published.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
