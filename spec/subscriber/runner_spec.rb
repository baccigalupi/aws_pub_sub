require "spec_helper"

RSpec.describe AwsPubSub::Subscriber::Runner do
  Processor = Struct.new(:message_data, :app_data) do
    attr_reader :has_run

    def run
      message_data.processor = self
      @has_run = true
    end
  end

  class Runner < AwsPubSub::Subscriber::Runner
    def processor_class
      Processor
    end

    def wrap_message(message)
      OpenStruct.new(message: message, success?: true)
    end

    def app_data
      OpenStruct.new(id: 'app_data')
    end
  end

  it "sets up the subscriber with the right queue name" do
    queue_name = 'queue_name'

    allow(AwsPubSub::Subscriber).to receive(:new) do |queue_name|
      expect(queue_name).to eq(queue_name)
      double(process_messages: true)
    end

    Runner.new(queue_name).run
  end

  it "wraps the messages provided by the block in the #wrap_message method" do
    message = OpenStruct.new(message_id: 'message-id')
    subscriber = double('subscriber')

    allow(AwsPubSub::Subscriber).to receive(:new).and_return(subscriber)

    expect(subscriber).to receive(:process_messages) do |&block|
      message_data = block.call(message)
      expect(message_data.message.message_id).to eq('message-id')
    end

    Runner.new('queue_name').run
  end

  it "passes the result of #app_data to the processor" do
    message = OpenStruct.new(message_id: 'message-id')
    subscriber = double('subscriber')

    allow(AwsPubSub::Subscriber).to receive(:new).and_return(subscriber)

    expect(subscriber).to receive(:process_messages) do |&block|
      message_data = block.call(message)
      expect(message_data.processor.app_data.id).to eq('app_data')
    end

    Runner.new('queue_name').run
  end

  it "calls #run on the processor" do
    message = OpenStruct.new(message_id: 'message-id')
    subscriber = double('subscriber')

    allow(AwsPubSub::Subscriber).to receive(:new).and_return(subscriber)

    expect(subscriber).to receive(:process_messages) do |&block|
      message_data = block.call(message)
      expect(message_data.processor.has_run).to eq(true)
    end

    Runner.new('queue_name').run
  end
end