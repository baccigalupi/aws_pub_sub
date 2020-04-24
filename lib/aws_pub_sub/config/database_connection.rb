# frozen_string_literal: true

module AwsPubSub
  module Config
    class DatabaseConnection
      attr_reader :logger, :option

      def initialize(logger, options = {})
        @logger = logger
        @options = options
      end

      def database
        @database ||= ::Sequel.connect(url, logger: logger)
      end

      def database_name
        "contakt_web_#{app_env}"
      end

      def url
        return ENV["DATABASE_URL"] if ENV["DATABASE_URL"]

        "postgres://#{username}:#{password}@#{host}:#{port}/#{database_name}"
      end

      private

      def username
        ENV.fetch("DATABASE_USER", `whoami`.strip)
      end

      def password
        ENV.fetch("DATABASE_PASSWORD", "")
      end

      def host
        ENV.fetch("DATABASE_HOST", "localhost")
      end

      def port
        ENV.fetch("DATABASE_PORT", "5432")
      end

      def app_env
        AwsPubSub::Config::Environment.new.env
      end
    end
  end
end
