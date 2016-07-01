class AddDefaultChannelToUserTable < ActiveRecord::Migration
  def change
    add_column :users, :slack_default_channel, :string
  end
end
