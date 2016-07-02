class User < ActiveRecord::Base
  include UserHelpers
  include SlackApiRequest
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:slack]

  serialize :slack_data, JSON

  def self.from_omniauth(auth)
    where(slack_id: auth.uid).first_or_create do |user|
      user.email =                  auth.info.email
      user.password =               Devise.friendly_token[0,20]
      user.slack_data =             auth
      user.slack_default_channel =  "general"
      user.image =                  auth.info.image
    end
  end

  def self.new_with_session(params, session)
    binding.pry
    super.tap do |user|
      if data = session["devise.slack_data"] && session["devise.slack_data"]["extra"]["raw_info"]
        binding.pry
        user.email = data["email"] if user.email.blank?
        binding.pry
      end
    end
  end

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

  def slack_nick_name
    slack_data["info"]["nickname"]
  end

end
