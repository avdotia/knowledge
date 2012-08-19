class AddTranslationsTable < ActiveRecord::Migration
  def up
    change_column :articles, :content, :text
    Article.create_translation_table! :title => :string, :content => :text
  end

  def down
    Article.drop_translation_table!
    change_column :articles, :content, :string
  end
end
