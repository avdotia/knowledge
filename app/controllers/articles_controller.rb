class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def new
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
    
    ##POR QUE NO ME FUNCIONA EL FLASH?
    flash[:notice] = "#{@article.title} was successfully updated."
    redirect_to article_path(@article)
  end  
end
