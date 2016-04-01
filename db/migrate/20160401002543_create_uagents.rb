class CreateUagents < ActiveRecord::Migration
  def change
    create_table :uagents do |t|
      t.text :browser
      t.text :os
    end
    remove_column :payload_requests, :user_agent_id
    add_column :payload_requests, :uagent_id, :integer
  end
end
