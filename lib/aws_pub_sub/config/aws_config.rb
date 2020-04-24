module AwsPubSub
  module Config
    module AwsConfig
      def self.region
        @region ||= ENV.fetch("AWS_REGION")
      end

      def self.credentials
        @credentials ||= Aws::Credentials.new(
          ENV.fetch("AWS_ACCESS_KEY_ID"),
          ENV.fetch("AWS_ACCESS_KEY_SECRET")
        )
      end
    end
  end
end