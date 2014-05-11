module HipChat
  class Notification
    # anyway to do it better (eg. in view?)
    include Rails.application.routes.url_helpers
    Rails.application.routes.default_url_options = { host: AppConfig.domain }

    attr_accessor :model

    def self.notify!(model)
      new(model).notify
    end

    def self.enabled?
      AppConfig.hipchat? and AppConfig.hipchat.token?
    end

    def initialize(model)
      @model = model
    end

    def notify
      if HipChat::Notification.enabled?
        client[AppConfig.hipchat.room].send("Help App", message, 
                                             message_format: 'text')
      end
    end

    def message
      "Implement me in subclass"
    end

    def url
      url_for(model)
    end

    def client
      @client ||= HipChat::Client.new(AppConfig.hipchat.token)
    end
  end
end
