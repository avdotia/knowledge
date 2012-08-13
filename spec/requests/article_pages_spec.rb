require 'spec_helper'

describe "Article Pages" do
  subject { page }
  describe "show" do
    let(:article) { FactoryGirl.create(:article) }
    before { visit article_path(article) }
    it { should have_selector('h1', text: article.title) }
    it { should have_selector('title', text: "Show") }
    
  end
  describe "add article" do
    let(:article) { FactoryGirl.create(:article) }
    before { visit new_article_path }
    it { should have_selector('h1', text: "Create a new article") }
  end
  describe "edit" do
    let(:article) { FactoryGirl.create(:article) }
    before { visit edit_article_path(article) }
    describe "page" do
      it { should have_selector('h1',    text: "Update the article") }
      it { should have_selector('title', text: "Edit user") }
      it { should have_link('Back to article', href: article_path(article)) } 
      it { should have_button 'Delete' } 
      
    end
    describe "with invalid information" do
      [:title, :content].each do |field|
        it "should fail if #{field} field is missing" do
            fill_in "article_#{field}", with: ""
            click_button "Update Article"
            should have_selector('div#flash-error', text: 'There were errors saving the article.')
     #     vemos mensaje de error           
            
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
      specify { article.reload.title.should == new_title }
      specify { article.reload.content.should == new_content }
      
    end
  end  
  
  describe "list articles" do
    before { visit articles_path }
    it { should have_selector('h1', text: "All Articles") }    
  end

end
