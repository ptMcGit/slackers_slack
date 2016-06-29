class ActivityController < ApplicationController
  def feed
    raise
  end
  #def feed
  #  resp = HTTParty.get "https://api.github.com/notifications",
   #                     headers: {
    #                      "Authorization" => "token #{current_user.github_token}",
     #                     "User-Agent"    => "silent aardwolf"
      #                  }

    #if resp.code == 200
    #  @events = resp
    #else
    #  raise "Panic!"
    #end
  #end
end
