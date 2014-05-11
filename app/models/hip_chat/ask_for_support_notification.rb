module HipChat
  class AskForSupportNotification < HipChat::Notification
    def message
      "#{model.receiver} asked for support #{model.user} - #{url}"
    end
  end
end
