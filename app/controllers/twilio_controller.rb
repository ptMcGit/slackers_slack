class TwilioController < ApplicationController
  def message
    @message = params["Body"]

  end
end
