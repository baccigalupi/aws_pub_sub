module AwsPubSub
  class Subscriber
    class Runner
      attr_reader :queue_name

      def initialize(queue_name)
        @queue_name = queue_name
      end

      def run
        AwsPubSub::Subscriber.new(queue_name).process_messages do |message|
          process_message(message)
        end
      end

      def process_message(message)
        message_data = wrap_message(message)
        processor_class.new(message_data, app_data).run

        # to let the queue container know to delete the message
        message_data
      end

      def processor_class
        raise NotImplementError
      end

      def wrap_message(message)
        raise NotImplementedError
      end

      def app_data
        raise NotImplementedError
      end
    end
  end
end
