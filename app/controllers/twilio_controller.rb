class TwilioController < ApplicationController
  protect_from_forgery except: :message

  include SlackApiRequest, UserHelpers
  def message
    @message = approved_params[:Body]
    @user = find_user_by_phone(phone_number_filter(approved_params[:From]))
    @channel = @user.slack_default_channel
    slack_post_message @message, @user, @channel
  end

  def approved_params
      params.permit(
      :Body,
      :From
    )
  end

  def find_user_by_phone phone_number
    User.all.find_by(encrypted_phone_number: hash_data(phone_number))
  end



  private

  def phone_number_filter number
    number[2..-1]
  end



end
