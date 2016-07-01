class AuthController < Devise::OmniauthCallbacksController
  include SlackApiRequest
  def slack
    data = request.env["omniauth.auth"]

    user = User.where(slack_id: data.uid).first_or_create! do |u|
      u.email                   = data.info.email
      u.password                = SecureRandom.hex 64
      u.slack_data              = data.to_h
      u.slack_default_channel   = "general"
    end

    sign_in user
    redirect_to after_callback_path, notice: "Signed in with Slack"
  end

end
