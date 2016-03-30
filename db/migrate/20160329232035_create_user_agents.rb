class CreateUserAgents < ActiveRecord::Migration
  def change
    create_table :user_agents do |t|
      t.text :browser
      t.text :os
    end
    remove_column :payload_requests, :user_agent
    add_column :payload_requests, :user_agent_id, :integer
  end
end
