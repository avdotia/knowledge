require 'spec_helper'

describe Article do
  
  before { @article = Article.new(title: "titulo de ejemplo", content: "contenido de ejemplo") }
  subject { @article }
  
  it { should respond_to(:title) }
  it { should respond_to(:content) }
end
