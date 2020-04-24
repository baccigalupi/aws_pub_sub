module AwsPubSub
  module Config
    class Environment
      attr_reader :env

      def initialize(env = ENV["APP_ENV"])
        @env = env || "development"
      end

      def load
        return unless local?
        Dotenv.load
      end

      def bundler_groups
        groups = [:default]
        groups << :test if test?
        groups << :development if development?
        groups
      end

      def local?
        test? || development?
      end

      def test?
        env == "test"
      end

      def development?
        env == "development"
      end
    end
  end
end
