class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def new
    @article = Article.new
  end
  def show
    id = params[:id]
    @article = Article.find(id)
  end
  def edit
    @article = Article.find(params[:id])
  end  
  def update
    @article = Article.find params[:id]
    @article.update_attributes!(params[:article])    
    flash[:notice] = "#{@article.title} was successfully updated."
    redirect_to article_path(@article)
  end  
  def create
    @article = Article.create!(params[:article])    
    flash[:notice] = "#{@article.title} was successfully created."
    redirect_to article_path(@article)
  end
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "#{@article.title} was succesfully deleted."
    redirect_to articles_url
  end
end
