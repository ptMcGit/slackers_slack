class TwilioController < ApplicationController
  include SlackApiRequest
  def message
    @message = approved_params[:Body]
    @user = User.find_user_by_phone(phone_number_filter(approved_params[:From]))
    slack_post_message @message, @user
  end

  def approved_params
      params.permit(
      :Body,
      :From
    )
  end

  private

  def phone_number_filter number
    number[2..-1]
  end



end
