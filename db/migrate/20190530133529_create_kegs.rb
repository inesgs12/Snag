class CreateKegs < ActiveRecord::Migration[5.2]
  def change
    create_table :kegs do |t|
      t.references :floor, foreign_key: true
      t.references :beer, foreign_key: true
      t.integer :status, default:3

      t.timestamps
    end
  end
end
