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
      flash[:notice] = t(:success_update_flash) 
      redirect_to article_path(@article)
    else
      flash[:error] = t(:error_saving_flash)
      render :edit
    end
  end  
  def create
    @article = Article.new(params[:article])
    if @article.save    
      flash[:notice] = t(:success_create_flash)
      redirect_to article_path(@article)
    else
      flash[:error] = t(:error_saving_flash)
      render :new
    end
  end
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = t(:success_destroy_flash)
    redirect_to articles_url
  end
end
