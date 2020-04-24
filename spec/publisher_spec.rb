require "spec_helper"

RSpec.describe AwsPubSub::Publisher do
  it "requires an arn for the topic to initialize" do
    expect {
      AwsPubSub::Publisher.new
    }.to raise_error(ArgumentError)

    expect {
      AwsPubSub::Publisher.new('my-topic-arn')
    }.not_to raise_error

    publisher = AwsPubSub::Publisher.new('my-topic-arn')
    expect(publisher.topic_arn).to eq('my-topic-arn')
  end 

  it "publishes json to the topic" do
    expect_any_instance_of(Aws::SNS::Client).to receive(:publish).with(
      topic_arn: 'my-topic-arn',
      message: {hello: 'world'}.to_json
    ).and_return(double(message_id: 'message-id'))

    publisher = AwsPubSub::Publisher.new('my-topic-arn')
    message_id = publisher.send_to_topic({hello: 'world'})
    expect(message_id).to eq('message-id')
  end
end