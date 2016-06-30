SlackApiUrl = "https://slack.com/api/"

module SlackApiRequest
  def slack_api_test
    return HTTParty.get SlackApiUrl + "api.test", Authorization: current_user.slack_token
  end

  def slack_test_authentication
    return HTTParty.get SlackApiUrl + "auth.test", query: { "token": current_user.slack_token }
  end

  def slack_post_message(message, user)
    return HTTParty.post SlackApiUrl + "chat.postMessage", query: { "token": user.slack_token, "channel": "C1METC0TH", "text": message }
  end

end
