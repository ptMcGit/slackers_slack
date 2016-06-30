

class ActivityController < ApplicationController
  def feed
    binding.pry
  end

  def post_message
    HTTParty.post "https://slack.com/api/chat.postMessage", query: { "token": current_user.slack_token, "channel": "C1METC0TH", "text": "hello, from the cli." }
  end

  def test_api
    HTTParty.get "https://slack.com/api/ap.test", Authorization: current_user.slack_token
  end

  def test_authentication
    HTTParty.get "https://slack.com/api/auth.test", query: { "token": current_user.slack_token }
  end
end
