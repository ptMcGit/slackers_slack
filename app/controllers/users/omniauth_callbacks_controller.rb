class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include SlackApiRequest
  def slack
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Slack") if is_navigational_format?
    else
        session["devise.slack_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end


    # user = User.where(slack_id: data.uid).first_or_create! do |u|
    #   u.email                   = data.info.email
    #   u.password                = SecureRandom.hex 64
    #   u.slack_data              = data.to_h
    #   u.slack_default_channel   = "general"
    # end

    # sign_in user
    # redirect_to user_settings_path, notice: "Signed in with Slack"
end
