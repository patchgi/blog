class AddNickname < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :screen_name, :string
  end
end
