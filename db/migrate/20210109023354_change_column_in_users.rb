class ChangeColumnInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :image, :string , default: "default-avatar"
  end
end
