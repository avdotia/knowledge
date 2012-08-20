class FixArticleContent < ActiveRecord::Migration
  def change
    change_table :articles do |t|
      t.change :content, :text, limit: nil
    end
  end
end
