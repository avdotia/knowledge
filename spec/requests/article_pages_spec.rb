require 'spec_helper'

describe "Article Pages" do
  subject { page }
  describe "show" do
   
    before do 
      @article = FactoryGirl.create(:article)
      @tag1 = FactoryGirl.create(:tag, name: "Author")
      @tag2 = FactoryGirl.create(:tag, name: "Book")
      @article.tags << @tag1
      @article.tags << @tag2
      visit article_path(@article, locale: I18n.default_locale)
    end
     
    it { should have_selector('h1') }
    it { should have_selector('title', text: "Show") }
  #  it { should have_selector('p', text: article.content) }
    it { should have_link('Edit', href: edit_article_path(@article, locale: I18n.default_locale)) }
    it { should have_link('Back to list', href: articles_path(locale: I18n.default_locale)) }
    it { should have_button 'Delete' }  
    describe "tags" do
      it { should have_content(@tag1.name) }
      it { should have_content(@tag2.name) }

    end    
  end
  
  describe "add new article" do
    before { visit new_article_path(locale: I18n.default_locale) }
    describe "page" do
      it { should have_selector('h1', content: "Create a new article") }
      it { should have_selector('title', text: "New article") }
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
      before do
        fill_in "article_title", with: new_title
        fill_in "article_content", with: new_content
        click_button "Create article"
      end
      it { should have_selector('div#flash-notice', text: "The article was successfully created.") }   
    end    
  end
  
  describe "edit" do
    let(:article) { FactoryGirl.create(:article) }
    before { visit edit_article_path(article, locale: I18n.default_locale) }
    describe "page" do
      it { should have_selector('h1',    content: "Update the article") }
      it { should have_selector('title', text: "Edit article") }
      it { should have_link('Back to article', href: article_path(article, locale: I18n.default_locale)) } 
      it { should have_button 'Delete' }       
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
      let(:new_title) { "New title" }
      let(:new_content) { "New content" }
      before do
        fill_in "article_title", with: new_title
        fill_in "article_content", with: new_content
        click_button "Update article"
      end
      it {should have_selector('div#flash-notice', text: "The article was successfully updated.")}
      specify { article.reload.title.should == new_title }
      specify { article.reload.content.should == new_content }           
    end
  end  
  
  describe "list articles" do
    it "has at least an article" do
      @article = FactoryGirl.create(:article)
      visit articles_path(locale: I18n.default_locale)
      should have_link(@article.title, href: article_path(@article, locale: I18n.default_locale)) 
    end
    before { visit articles_path(locale: I18n.default_locale) }
    let(:article) { FactoryGirl.create(:article) }
    describe "page" do
      it { should have_link('Add new article', href: new_article_path(locale: I18n.default_locale)) } 
      it { should have_selector('h1', text: "All articles") }  
      it { should have_selector('title', text: "Index") }       
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
##########PARA CREACION
#    describe "article release associations" do

#      before { @article.save }
#      let!(:older_article) do 
#        FactoryGirl.create(:article, created_at: 1.day.ago)
#      end
#      let!(:newer_article) do
#        FactoryGirl.create(:article, created_at: 1.hour.ago)
#      end
  
#      it "should have the right articles in the right order" do
#        article.should == [newer_article, older_article]
#      end
#    end
  end
end
