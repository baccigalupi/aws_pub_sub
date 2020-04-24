require "spec_helper"

RSpec.describe AwsPubSub::Subscriber do
  before do
    allow_any_instance_of(Aws::SQS::Client).to receive(:get_queue_url)
      .and_return(double(queue_url: 'queue_url'))
  end

  it "requires a queue name" do
    expect {
      AwsPubSub::Subscriber.new
    }.to raise_error(ArgumentError)

    expect {
      AwsPubSub::Subscriber.new('my-queue-name')
    }.not_to raise_error

    subscriber = AwsPubSub::Subscriber.new('my-queue-name')
    expect(subscriber.queue_name).to eq('my-queue-name')
  end

  it "#polls calls the block with each message" do
    messages = [
      double('success message'),
      double('failed message')
    ]

    expect_any_instance_of(Aws::SQS::QueuePoller).to receive(:poll) do |&block|
      block.call(messages)
    end

    subscriber = AwsPubSub::Subscriber.new('my-queue-name')
    processed_messages = []
    
    subscriber.process_messages do |message|
      processed_messages << message
      double(success?: false) # don't call delete on the message
      # just to avoid more stubbing in this test
    end

    expect(processed_messages).to eq(messages)
  end

  it "#poll will delete messages in the queue when block returns message_data with #success? returning true" do
    messages = [
      double('success message', success?: true, receipt_handle: 'success-message'),
      double('failed message', success?: false, receipt_handle: 'failure-message')
    ]

    expect_any_instance_of(Aws::SQS::QueuePoller).to receive(:poll) do |&block|
      block.call(messages)
    end

    expect_any_instance_of(Aws::SQS::Client).to receive(:delete_message)
      .with({
        queue_url: 'queue_url',
        receipt_handle: 'success-message'
      })

    subscriber = AwsPubSub::Subscriber.new('my-queue-name')

    subscriber.process_messages do |message|
      message
    end
  end
end