class User < ActiveRecord::Base
  include UserHelpers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:slack]

  serialize :slack_data, JSON

  def slack_token
    slack_data["credentials"]["token"]
  end

  def encrypted_phone_number=(val)
    write_attribute(:encrypted_phone_number, hash_data(val))
  end
end
