module AwsPubSub
  class Subscriber
    class ProcessStep
      attr_reader :message_data, :app_data

      def initialize(message_data, app_data)
        @message_data = message_data
        @app_data = app_data
      end

      def run
        return if message_data.abort

        log_preface
        process
        log_result
        log_conclusion
      rescue => e
        message_data.abort = true
        log_error(e)
        log_result
        log_conclusion
      end

      def process
        raise NotImplementedError
      end

      def result
      end

      def log_preface
        logger.info("#{log_prefix} Starting processing #{message_id}")
      end

      def log_result
        return unless result
        logger.debug(
          "#{log_prefix} Result #{message_id}\n  #{result}"
        )
      end

      def log_error(error)
        logger.error(
          <<~LOG
            #{log_prefix} Error while processing #{message_id}
            #{error.inspect}
            #{error.backtrace.join("\n")}
          LOG
        )
      end

      def log_conclusion
        logger.info("#{log_prefix} Finished processing #{message_id}")
      end

      def log_prefix
        self.class.name
      end

      def message
        message_data.message
      end

      def message_id
        message.message_id
      end

      def logger
        app_data.logger
      end
    end
  end
end
