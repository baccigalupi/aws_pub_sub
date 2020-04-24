require "spec_helper"

RSpec.describe AwsPubSub::Subscriber::ProcessMessage do
  ProcessorBase = Struct.new(:message_data, :app_data) do
    def run
      message_data.processors ||= []
      message_data.processors << self
    end
  end
  class Processor1 < ProcessorBase; end 
  class Processor2 < ProcessorBase; end 
  
  class ProcessMessage < AwsPubSub::Subscriber::ProcessMessage
    def processor_classes
      [
        Processor1,
        Processor2
      ]
    end
  end

  it "runs each of the processor classes with the right data" do
    message_data = OpenStruct.new
    app_data = OpenStruct.new

    message_processor = ProcessMessage.new(message_data, app_data)
    message_processor.run

    expect(message_data.processors.size).to eq(2)

    expect(message_data.processors.first.message_data).to eq(message_data)
    expect(message_data.processors.first.app_data).to eq(app_data)

    expect(message_data.processors.last.message_data).to eq(message_data)
    expect(message_data.processors.last.app_data).to eq(app_data)
  end
end