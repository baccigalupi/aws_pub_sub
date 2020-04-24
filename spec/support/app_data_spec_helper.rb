module AwsPubSub  
  module AppDataSpecHelper
    def create_logger
      @logger_content = StringIO.new("")
      @logger = Logger.new(@logger_content)
    end

    def logger
      @logger
    end

    def logger_content
      return unless @logger_content
      @logger_content.string
    end

    def database
      @database ||= AwsPubSub::Config::DatabaseConnection.new(
        AwsPubSub::Config::BuildLogger.new.run
      ).database
    end

    def app_data
      ContaktInboundEmail::AppData.new(create_logger, database)
    end

    def clean_up_database
      database
        .tables
        .reject { |table| [:schema_info, :schema_migrations].include?(table) }
        .each { |table| database.run("DELETE FROM #{table};") }
    end
  end
end
