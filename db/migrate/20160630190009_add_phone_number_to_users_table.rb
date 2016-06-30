class AddPhoneNumberToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :encrypted_phone_number, :string
  end
end
