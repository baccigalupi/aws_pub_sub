module AwsPubSub
  class Subscriber
    attr_reader :queue_name 

    def initialize(queue_name, credentials: nil, region: nil)
      @queue_name = queue_name
      @credentials = credentials
      @region = region
    end

    def process_messages(&block)
      poller.poll(poll_options) do |messages|
        messages.each do |message|
          process_message(message, &block)
        end
      end
    end

    private

    def process_message(message, &block)
      message_data = block.call(message)

      if message_data.success?
        sqs_client.delete_message(
          queue_url: queue_url,
          receipt_handle: message.receipt_handle
        )
      end
    end

    def poller
      @poller ||= Aws::SQS::QueuePoller.new(queue_url, {
        client: sqs_client
      })
    end

    def poll_options
      {
        max_number_of_messages: 10,
        skip_delete: true
      }
    end

    def queue_url
      @queue_url ||= sqs_client.get_queue_url(
        queue_name: queue_name
      ).queue_url
    end

    def sqs_client
      @sqs_client ||= Aws::SQS::Client.new(
        region: region,
        credentials: credentials
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