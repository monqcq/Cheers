class ChangeColumnDefaultToUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :introduction, :string, default: "よろしくお願いします"
  end

  def down
    change_column :users, :introduction, :string
  end

end
