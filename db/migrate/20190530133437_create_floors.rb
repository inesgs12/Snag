class CreateFloors < ActiveRecord::Migration[5.2]
  def change
    create_table :floors do |t|
      t.integer :floor_number
      t.integer :cups, default:3

      t.timestamps
    end
  end
end
