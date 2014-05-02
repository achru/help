module HipChat
  class Notification
    include Rails.application.routes.url_helpers
    Rails.application.routes.default_url_options = { host: AppConfig.domain } # anyway to do it better?

    attr_accessor :client, :model

    def self.notify!(model)
      new(model).notify
    end

    def initialize(model)
      @client = HipChat::Client.new(AppConfig.hipchat.token)
      @model = model
    end
     
    def notify
      client[AppConfig.hipchat.room].send("Help App", message, message_format: 'text')
    end

    def message
      'Implement this in specific notification'
    end

    def url
      url_for(model)
    end

  end
end
