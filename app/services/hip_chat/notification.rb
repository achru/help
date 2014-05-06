module HipChat
  class Notification
    # anyway to do it better (eg. in view?)
    include Rails.application.routes.url_helpers
    Rails.application.routes.default_url_options = { host: AppConfig.domain }

    attr_accessor :client, :model

    def self.notify!(model)
      new(model).notify
    end

    def initialize(model)
      @client = HipChat::Client.new(AppConfig.hipchat.token)
      @model = model
    end

    def notify
      if Rails.application.config.enable_hipchat_notifications
        client[AppConfig.hipchat.room].send("Help App", message, message_format: 'text')
      end
    end

    def message
      "Implement me in subclass"
    end

    def url
      url_for(model)
    end
  end
end
