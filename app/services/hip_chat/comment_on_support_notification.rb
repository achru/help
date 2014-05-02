module HipChat
  class CommentOnSupportNotification < HipChat::Notification

    def message
      "#{model.user} commented on support - #{url}"
    end

    def url
      url_for(model.support)
    end

  end
end
