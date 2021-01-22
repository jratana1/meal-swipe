class ChangeColumnDefaultInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :image, :string , default: "default-avatar.jpg"
  end
end
