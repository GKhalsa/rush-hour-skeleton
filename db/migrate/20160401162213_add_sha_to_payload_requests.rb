class AddShaToPayloadRequests < ActiveRecord::Migration
  def change
    add_column :payload_requests, :sha, :text
  end
end
