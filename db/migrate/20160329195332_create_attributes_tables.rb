class CreateAttributesTables < ActiveRecord::Migration
  def change
    create_table :referrers do |t|
      t.text :name
    end

    create_table :urls do |t|
      t.text :url_path
    end

    create_table :request_types do |t|
      t.text :name
    end

    create_table :event_names do |t|
      t.text :name
    end

    create_table :user_agents do |t|
      t.text :agent
      t.text :browser
      t.text :os
    end

    create_table :resolutions do |t|
      t.integer :resolution_height
      t.integer :resolution_width
    end

    create_table :ips do |t|
      t.inet :ip
    end
  end
end
