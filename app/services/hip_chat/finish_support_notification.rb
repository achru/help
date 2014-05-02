module HipChat
  class FinishSupportNotification < HipChat::Notification

    def message
      "#{model.user} helped #{model.receiver} with #{model.topic} - #{url}"
    end

  end
end
