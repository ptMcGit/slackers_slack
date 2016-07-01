class User < ActiveRecord::Base
  include UserHelpers
  include SlackApiRequest
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

  def slack_team_name
    slack_data["info"]["team"]
  end

  def slack_channels
    channels = slack_get_channels(self)
    channels.map { |channel| channel["name"] }
  end

  def slack_user_name
    slack_data["info"]["user"]
  end


end
