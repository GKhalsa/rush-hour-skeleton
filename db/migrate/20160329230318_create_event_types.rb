class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
      t.text :name
    end
    remove_column :payload_requests, :event_name
    add_column :payload_requests, :event_type_id, :integer
  end
end
