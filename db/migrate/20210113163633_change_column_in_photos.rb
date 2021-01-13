class ChangeColumnInPhotos < ActiveRecord::Migration[6.0]
  def change
    change_column :photos, :leftswipes, :integer , default: 0
    change_column :photos, :rightswipes, :integer , default: 0
  end
end
