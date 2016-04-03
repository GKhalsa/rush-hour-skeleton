class ChangePayloadRequest < ActiveRecord::Migration
  def change
    remove_column :payload_requests, :ip
    add_column :payload_requests, :ip, :text
  end
end
