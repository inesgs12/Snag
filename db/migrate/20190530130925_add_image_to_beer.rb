class AddImageToBeer < ActiveRecord::Migration[5.2]
  def change
    add_column :beers, :image, :string
  end
end
