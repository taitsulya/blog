# frozen_string_literal: true

class ArticlesController < ApplicationController
  after_action :show_changes, only: %i[create update destroy]
  around_action :info

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def show_pdf
    @article = Article.find(params[:id])
    respond_to do |format|
      format.pdf do
        render pdf: "article#{@article.id}"
      end
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path
  end

  private

  def show_changes
    puts 'Article: '
    @article.attributes.each { |key, value| puts "  #{key}: #{value}" }
  end

  def info
    before
    yield
    after
  end

  def before
    before = "BEFORE ACTION\n"
    before << "Request method: #{request.method}\nIP: #{request.ip}\nPath: #{request.path}\nRequest parameters:\n"
    request.params.each { |key, value| before << "  #{key}: #{value}\n" }
    puts before
  end

  def after
    after = "AFTER ACTION\n"
    after << "Response status: #{response.status} #{response.message}"
    puts after
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
