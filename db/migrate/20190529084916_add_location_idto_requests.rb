class AddLocationIdtoRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :location_id, :string
  end
end
