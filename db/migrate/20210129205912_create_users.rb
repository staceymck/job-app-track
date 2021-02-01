class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false, index: {unique: true}
      t.string :password_digest
    end
  end
end
