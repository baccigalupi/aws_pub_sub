module AwsPubSub
  class Subscriber
    class ProcessMessage
      attr_reader :message_data, :app_data
  
      def initialize(message_data, app_data)
        @message_data = message_data
        @app_data = app_data
      end
  
      def run
        processor_classes.each do |klass|
          klass.new(message_data, app_data).run
        end
        message_data
      end
  
      def processor_classes
        [
          # subclass and fill me in
        ]
      end
    end
  end
end
    