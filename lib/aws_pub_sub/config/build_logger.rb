module AwsPubSub
  module Config
    class BuildLogger
      def run
        logger = ::Logger.new(log_output)
        logger.level = level
        logger
      end

      private

      def log_output
        return log_file if log_to_file?

        $stdout
      end

      def level
        return ::Logger::DEBUG if env == "test" || env == "development"

        ::Logger::INFO
      end

      def log_file
        File.join(Dir.pwd, "log/#{env}.log")
      end

      def env
        Environment.new.env
      end

      def log_to_file?
        ENV['LOG_TO_STDOUT'] != "true" && env == "test"
      end
    end
  end
end
