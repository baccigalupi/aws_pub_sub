module AwsPubSub
  class Publisher
    attr_reader :topic_arn 

    def initialize(topic_arn, credentials: nil, region: nil)
      @topic_arn = topic_arn
      @credentials = credentials
      @region = region
    end

    def send_to_topic(message)
      response = sns_client.publish(
        topic_arn: topic_arn,
        message: message.to_json
      )
      response.message_id
    end

    private

    def sns_client
      @sns_client ||= Aws::SNS::Client.new(
        credentials: credentials,
        region: region
      )
    end

    def credentials
      @credentials ||= Config::AwsConfig.credentials
    end

    def region
      @region ||= Config::AwsConfig.region
    end
  end
end