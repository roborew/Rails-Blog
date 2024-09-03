class MoveBodyToActionText < ActiveRecord::Migration[7.2]
  def change
    Article.all.find_each do |article|
      article.update(content: article.body)
    end

    remove_column :articles, :body, :text
  end
end
