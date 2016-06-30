class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:slack]

  serialize :slack_data, JSON

  def slack_token
    slack_data["credentials"]["token"]
  end

  def self.find_user_by_phone phone_number
    User.all.find_by(encrypted_phone_number: self.hash_data(phone_number))
  end

  private

  def self.hash_data data
    Digest::SHA256.hexdigest(data)
  end

end
