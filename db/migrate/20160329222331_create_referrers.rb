class CreateReferrers < ActiveRecord::Migration
  def change
    create_table :referrers do |t|
      t.text :address
    end
    remove_column :payload_requests, :referred_by
    add_column :payload_requests, :referrer_id, :integer
  end
end
