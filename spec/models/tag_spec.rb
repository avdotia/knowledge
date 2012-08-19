require 'spec_helper'

describe Tag do
  let(:article) { FactoryGirl.create(:article) }
  before { @tag = article.tags.build(name: "Winter") }

  subject { @tag }

  it { should respond_to(:name) }

  it { should respond_to(:articles) }
## ¿?¿?¿?¿--->>>>  its(:article) { should == article }
  it { should be_valid }
  describe "when name is blank" do
    before { @tag.name = "" }
    it { should_not be_valid }
  end
  describe "when the name is too long" do
    before { @tag.name = "a" * 64 }
    it { should_not be_valid }
  end
#describe "accessible attributes" do
#  it "should not allow access to user_id" do
#    expect do
#      Micropost.new(user_id: user.id)
#    end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
#  end    
#end
end
