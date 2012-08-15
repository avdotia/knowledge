class ArticlesController < ApplicationController
  def index
   @field = params[:order_by] || 'id'
   @direction = params[:direction].try(:upcase) == 'ASC' ? 'ASC' : 'DESC'
   @articles = Article.paginate(page: params[:page], order: "#{@field} #{@direction}").search(params[:search])
 #  @articles = Article.search(params[:search])
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
    if @article.update_attributes(params[:article])    
      flash[:notice] = "#{@article.title} was successfully updated."
      redirect_to article_path(@article)
    else
      flash[:error] = "There were errors saving the article."
      render :edit
    end
  end  
  def create
    @article = Article.new(params[:article])
    if @article.save    
      flash[:notice] = "#{@article.title} was successfully created."
      redirect_to article_path(@article)
    else
      flash[:error] = "There were errors saving the article."
      render :new
    end
  end
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "#{@article.title} was succesfully deleted."
    redirect_to articles_url
  end
end
