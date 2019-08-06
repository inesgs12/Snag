class ChangeFirstAndLastNameToName < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :first_name, :name
    remove_column :users, :last_name
  end
end
