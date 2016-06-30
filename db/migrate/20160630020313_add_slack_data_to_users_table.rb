class AddSlackDataToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :slack_data, :text
  end
end
