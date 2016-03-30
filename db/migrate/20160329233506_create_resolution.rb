class CreateResolution < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.integer :width
      t.integer :height
    end
    remove_column :payload_requests, :resolution_width
    remove_column :payload_requests, :resolution_height
    add_column :payload_requests, :resolution_id, :integer
  end
end
