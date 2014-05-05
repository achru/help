module HipChat
  class CommentOnSupportNotification < HipChat::Notification
    def url
      url_for(model.support)
    end
  end
end
