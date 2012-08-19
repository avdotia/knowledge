class ArticlesController < ApplicationController
  def index
   @field = params[:order_by] || 'id'
   @direction = params[:direction].try(:upcase) == 'ASC' ? 'ASC' : 'DESC'
   @articles = Article.paginate(page: params[:page], order: "#{@field} #{@direction}").search(params[:search])
 #  @articles = Article.search(params[:search])
  end
  def new
    @article = Article.new
    @tags = []
  end
  def show
    id = params[:id]
    @article = Article.find(id)
    @tags = @article.tags
  end
  def edit
    @article = Article.find(params[:id])
    @tags = @article.tags.map(&:name).join(' ')
  end  
  def update
    @article = Article.find params[:id]
    tag_names = params[:tags].split(' ').uniq
    form_tags = tag_names.map {|tag| Tag.find_or_create_by_name(tag)}
    article_tags = @article.tags
    new_tags = form_tags - article_tags
    old_tags = article_tags - form_tags
    new_tags.each do |tag|
      @article.tags << tag
    end
    old_tags.each do |tag|
      @article.tags.destroy(tag)
    end
    @tag = @article.tags.map(&:name).join(' ')
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
      tag_names = params[:tags].split(' ').uniq
      tag_names.each do |tag|
        @article.tags << Tag.find_or_create_by_name(tag)
      end
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
  def filter
    @tag = Tag.find_by_name(params[:id])
    @articles = @tag.articles
  end
end
