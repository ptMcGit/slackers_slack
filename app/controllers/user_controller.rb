class UserController < ApplicationController
  include UserHelpers, SlackApiRequest

  def show
    @user = current_user
    @channels = slack_get_channels(current_user)
  end

  def update_slack_channel_from_button
    current_user.slack_default_channel = params["slack_default_channel"]
    current_user.save
    redirect_to :back
  end

  def update
    pn = filter_phone_number(params["phone_number"])
    if valid_phone_number?(pn)
      current_user.encrypted_phone_number = pn
      current_user.slack_default_channel = params["user"]["slack_default_channel"]
      current_user.save
    else
      current_user.errors.add(:base, "The phone number you entered is invalid.")
    end
    if current_user.errors.any?
      redirect_to user_settings_path
      flash[:error] = current_user.errors.full_messages
    else
      flash[:notice] = "You have succesfully updated your settings."
      redirect_to root_path
    end
  end

end
