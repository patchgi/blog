class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :image_url, default: 'http://www.warawareotoko.com/wp-content/uploads/2013/09/appbank.png'
      t.timestamps null: false
    end
  end
end
