module App
  class ProcessMessage
    class Parse < AwsPubSub::Subscriber::ProcessStep
      def process
        # change the message data -or-
        # update the database -or-
        # you choose!
      end

      def result
        # what you would like to log about the result of this step
      end

      def message_body
        JSON.parse(JSON.parse(message.body)["Message"])
      end
    end
  end
end
