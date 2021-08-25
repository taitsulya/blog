# frozen_string_literal: true

class ArticlesController < ApplicationController
  after_action :show_changes, only: %i[create update destroy]
  around_action :info

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def show_pdf
    @article = Article.find(params[:id])
    render pdf: "article#{@article.id}"
  end

  def show_xml
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article successfully created' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html do
          flash.now[:alert] = 'Incorrect article'
          render :new, status: :unprocessable_entity
        end
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  private

  def show_changes
    Rails.logger.debug 'Article: '
    @article.attributes.each { |key, value| Rails.logger.debug "  #{key}: #{value}" }
  end

  def info
    before
    yield
    after
  end

  def before
    Rails.logger.debug do
      "BEFORE ACTION\nRequest method: #{request.method}\nIP: #{request.ip}\nPath: #{request.path}\nRequest parameters:"
    end
    request.params.each { |key, value| Rails.logger.debug "  #{key}: #{value}" }
  end

  def after
    Rails.logger.debug 'AFTER ACTION'
    Rails.logger.debug { "Response status: #{response.status} #{response.message}" }
  end

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def record_not_found
    respond_to do |format|
      format.html { render plain: 'User not found', status: :not_found }
      format.pdf { render html: 'User not found. Unable to create pdf', status: :not_found }
      format.xml { render :error, status: :not_found }
      format.json { render json: { error: 'not-found' }.to_json, status: :not_found }
    end
  end
end
