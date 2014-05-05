module HipChat
  class Notification
    #anyway to do it better (eg. in view?)
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
      client[AppConfig.hipchat.room].send("Help App", message.strip, message_format: 'text')
    end

    def message
      view = ActionView::Base.new(ActionController::Base.view_paths)
      view.render(file: view_path, locals: { model: model, url: url}).to_s
    end

    def url
      url_for(model)
    end

    def view_path
      base_view_path + self.class.name.demodulize.underscore 
    end

    def base_view_path
      'hipchat_notifications/'
    end
  end
end
