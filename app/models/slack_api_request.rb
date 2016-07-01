SlackApiUrl = "https://slack.com/api/"

module SlackApiRequest
  def slack_api_test
    return HTTParty.get SlackApiUrl + "api.test", Authorization: current_user.slack_token
  end

  def slack_test_authentication
    return HTTParty.get SlackApiUrl + "auth.test", query: { "token": current_user.slack_token }
  end

  def slack_post_message(message, user, channel)
    return HTTParty.post \
                      SlackApiUrl + "chat.postMessage",
           query: {
             "token": user.slack_token,
                   "channel": channel,
                   "text": message,
                   "as_user": "true"
           }
  end

  def slack_get_channels(user)
    HTTParty.post SlackApiUrl + "channels.list", query: { "token": user.slack_token }
  end

end
