require 'spec_helper'

describe "Article Pages" do
  subject { page }
  describe "show" do
    let(:article) { FactoryGirl.create(:article) }
    before { visit article_path(article) }
    it { should have_selector('h1', text: article.title) }
    it { should have_selector('title', text: "Hola") }
    
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
    end

#    describe "with invalid information" do
#      before { click_button "Save changes" }
#      it { should have_content('error') }
#    end
  end  
  describe "list articles" do
    before { visit articles_path }
    it { should have_selector('h1', text: "All Articles") }    
  end

end
