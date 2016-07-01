class WelcomeController < ApplicationController
  include UserHelpers
  def index
  end

  def after_callback
    @user = current_user
  end

  def after_callback_save
    pn = filter_phone_number(params["phone_number"])
    if valid_phone_number?(pn)
      current_user.encrypted_phone_number = pn
      current_user.slack_default_channel = params["user"]["slack_default_channel"]
      current_user.save
    else
      errors.add(:base, "that phone number is invalid")
    end
    if current_user.errors.any?
      @user = current_user
      @errors = current_user.errors.messages
      render 'after_callback'
    else
      redirect_to root_path
    end
  end
end
