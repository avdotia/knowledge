require 'spec_helper'

describe "Article Pages" do
  subject { page }
  describe "show" do
    let(:article) { FactoryGirl.create(:article) }
    before { visit article_path(article) }
    it { should have_selector('h1', text: article.title) }
    it { should have_selector('title', text: "Show") }
    it { should have_selector('p', text: article.content) }
    it { should have_link('Edit', href: edit_article_path(article)) }
    it { should have_link('Back to list', href: articles_path) }
    ##test button delete??
    it { should have_button 'Delete' }      
  end
  
  describe "add new article" do
   # let(:article) { FactoryGirl.create(:article) }
    before { visit new_article_path }
    describe "page" do
      it { should have_selector('h1', text: "Create a new article") }
      it { should have_selector('title', text: "New Article") }
      it { should have_link('Back to list', href: articles_path) }
    end
    describe "with invalid information" do
      [:title, :content].each do |field|
        it "should fail if #{field} field is missing" do
            fill_in "article_#{field}", with: ""
            click_button "Create Article"
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
        click_button "Create Article"
      end
      ##parece que funciona sin el text
      it { should have_selector('div#flash-notice') }   
      ##Creo que specify no va    
    end    
  end
  
  describe "edit" do
    let(:article) { FactoryGirl.create(:article) }
    before { visit edit_article_path(article) }
    describe "page" do
      it { should have_selector('h1',    text: "Update the article") }
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('Back to article', href: article_path(article)) } 
      ##test delete?
      it { should have_button 'Delete' }       
    end
    describe "with invalid information" do
      [:title, :content].each do |field|
        it "should fail if #{field} field is missing" do
            fill_in "article_#{field}", with: ""
            click_button "Update Article"
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
        click_button "Update Article"
      end
      it {should have_selector('div#flash-notice')}
      specify { article.reload.title.should == new_title }
      specify { article.reload.content.should == new_content }           
    end
  end  
  
  describe "list articles" do
    before { visit articles_path }
    describe "page" do
      it { should have_link('Add new article', href: new_article_path) } 
      it { should have_selector('h1', text: "All Articles") }  
      it { should have_selector('title', text: "Index") }  
   # it { should have_link(href: article_path) }
    end
    let(:article) { FactoryGirl.create(:article) }
    before(:all) { 30.times { FactoryGirl.create(:article) } }
    after(:all) { Article.delete_all }
    describe "pagination" do
      
    end

  end

end
