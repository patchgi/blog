class AddArticlesUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :article_url, :string
  end
end
