module App
  module Types
    AppData = Struct.new(
      :logger,
      :database
    ) {
      def self.build
        new(
          AwsPubSub::Config::BuildLogger.new.run,
          AwsPubSub::Config::DatabaseConnection.new(logger).database
        )
      end
    }
  end
end
