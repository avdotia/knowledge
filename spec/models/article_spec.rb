require 'spec_helper'

describe Article do
  
  before { @article = Article.new(title: "titulo de ejemplo", content: "contenido de ejemplo") }
#@article is the default subject of the test
#so we can leave @article out of the test yielding 
  subject { @article }
  
  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:tags) }
#Validate the presence  of attributes' tests
  it { should be_valid }
  describe "when the title is not present" do
    before { @article.title = " " }
    it { should_not be_valid }
  end  
  describe "when the content is not present" do
    before { @article.content = " " }
    it { should_not be_valid }
  end    
#Lenght validation
  describe "when the title is too long" do
    before { @article.title = "." * 51 }
    it { should_not be_valid }
  end
#Relationship between articles and tags
  describe "tags associations" do
    before { @article.save }
#    it "should destroy associated tags" do
#      tags = @article.tags
#      @article.destroy
#      tags.each do |tag|
#        Tag.find_by_id(tag.id).should be_nil
#      end
#    end
  end  
end
