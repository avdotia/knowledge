require 'spec_helper'

describe "Article Pages" do
  subject { page }
  
  describe "show" do   
    before do 
      @article = FactoryGirl.create(:article, title: "Moby Dick", content: "The Whale is a novel by Herman Melville, first published in 1851")
      @tag1 = FactoryGirl.create(:tag, name: "Author")
      @article.tags << @tag1
      visit article_path(@article, locale: I18n.default_locale)
    end
    it { should have_link('es', href: article_path(@article, locale: :es)) } 
    it { should have_selector('h1') }
    it { should have_selector('title', text: "Show") }
    it { should have_link('Edit', href: edit_article_path(@article, locale: I18n.default_locale)) }
    it { should have_link('Back to list', href: articles_path(locale: I18n.default_locale)) }
    it { should have_button 'Delete' } 
    it { should have_content(@tag1.name) }
    it { should have_content(@article.title) } 
    it { should have_content(@article.content) }  
  end
  
  describe "add new article" do
    before { visit new_article_path(locale: I18n.default_locale) }
    describe "page" do
      it { should have_selector('title', text: "New article") }
      it { should have_link('es', href: new_article_path(locale: :es)) }
      it { should have_selector('h1', content: "Create a new article") }      
      it { should have_link('Back to list', href: articles_path(locale: I18n.default_locale)) }      
    end
    describe "with invalid information" do
      [:title, :content].each do |field|
        it "should fail if #{field} field is missing" do
            fill_in "article_#{field}", with: ""
            click_button "Create article"
            should have_selector('div#flash-error', text: 'There were errors saving the article.')
        end
      end
    end
    describe "with valid information" do
      let(:new_title) { "New title" }
      let(:new_content) { "New content" }
      let(:tag) { FactoryGirl.create(:tag, name: "hola") }
      before do
        fill_in "article_title", with: new_title
        fill_in "article_content", with: new_content
        fill_in "tags", with: tag.name        
        click_button "Create article"
      end
      it { should have_selector('div#flash-notice', text: "The article was successfully created.") }   
    end    
  end
  
  describe "edit" do
    before do
      @article = FactoryGirl.create(:article, title: "Moby Dick", content: "The Whale is a novel by Herman Melville, first published in 1851") 
      @tag = FactoryGirl.create(:tag, name: "Author")
      @article.tags << @tag
      visit edit_article_path(@article, locale: I18n.default_locale)
    end
    describe "page" do
      it { should have_selector('title', text: "Edit article") }
      it { should have_link('es', href: edit_article_path(@article, locale: :es)) }
      it { should have_selector('h1',    content: "Update the article") }
      it { should have_link('Back to article', href: article_path(@article, locale: I18n.default_locale)) } 
      it { should have_button 'Delete' }      
      it { should have_selector("input", value: @article.title) } 
      it { should have_content(@article.content) }        
    end
    describe "with invalid information" do
      [:title, :content].each do |field|
        it "should fail if #{field} field is missing" do
            fill_in "article_#{field}", with: ""
            click_button "Update article"
            should have_selector('div#flash-error', text: 'There were errors saving the article.')
        end
      end
    end
    describe "with valid information" do
      before do
        fill_in "article_title", with: @article.title
        fill_in "article_content", with: @article.content
        fill_in "tags", with: @tag.name
        click_button "Update article"
      end
      it {should have_selector('div#flash-notice', text: "The article was successfully updated.")}
      specify { @article.reload.title.should == @article.title }
      specify { @article.reload.content.should == @article.content }
      specify { @tag.reload.name.should == @tag.name }           
    end
  end  
  
  describe "list articles" do
    before do
      @article = FactoryGirl.create(:article)
      visit articles_path(locale: :en)
    end
    it "has at least an article" do
      should have_link(@article.title, href: article_path(@article, locale: :en)) 
    end
    describe "page" do
      it { should have_selector('title', text: "Index") }
      it { should have_selector('h1', text: "All articles") }
      it { should have_link('Add new article', href: new_article_path(locale: :en)) }             
    end
    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:article) } }
      after(:all) { Article.delete_all }
      it { should have_selector('li') }
      it "should list each article" do
        Article.paginate(page: 1).each do |article|
          page.should have_selector("li", text: article.title)
        end
      end
    end
  end
end
