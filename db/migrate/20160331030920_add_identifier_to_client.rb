class AddIdentifierToClient < ActiveRecord::Migration
  def change
    add_column :clients, :identifier, :text
  end
end
