require ""

module App
  class Runner < AwsPubSub::Subscriber::Runner
    def processor_class
      ProcessMessage
    end

    def wrap_message(message)
      MessageData.new(message)
    end

    def app_data
      @app_data ||= AppData.build
    end
  end
end
