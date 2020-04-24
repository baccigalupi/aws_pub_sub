require "spec_helper"

RSpec.describe AwsPubSub::Subscriber::ProcessStep do
  let(:message_data) {
    OpenStruct.new(
      message: OpenStruct.new(message_id: 'message-id'),
      success?: true
    )
  }

  let(:app_data) {
    OpenStruct.new(logger: create_logger)
  }

  class GoodProcessStep < AwsPubSub::Subscriber::ProcessStep
    def process
      message_data.has_run = true
    end

    def result
      "hey this worked"
    end
  end

  class BadProcessStep < AwsPubSub::Subscriber::ProcessStep
    def process
      raise ArgumentError.new("Hey, I don't know. Things went wrong")
    end
  end

  it "#run wraps the require process method" do
    process_step = AwsPubSub::Subscriber::ProcessStep.new(
      message_data, app_data
    )

    expect {
      process_step.run
    }.to raise_error(NotImplementedError)
  end


  describe "when process is a sucesss" do
    it "logs on both sides of the process" do
      GoodProcessStep.new(message_data, app_data).run

      expect(logger_content).to include(
        "GoodProcessStep Starting processing"
      )
      expect(logger_content).to include(
        "GoodProcessStep Finished processing"
      )
    end

    it "also logs a debug statemest with the result" do
      GoodProcessStep.new(message_data, app_data).run

      expect(logger_content).to match(
        /DEBUG.*GoodProcessStep Result message-id.*hey this worked/m
      )
    end

    it "it leaves the `abort` flay on message_data as falsey" do
      GoodProcessStep.new(message_data, app_data).run

      expect(message_data.abort).to be_falsey
    end
  end

  describe "when the process raises an error" do
    it "sets `abort` on the message_data to true of failure" do
      BadProcessStep.new(message_data, app_data).run

      expect(message_data.abort).to eq(true)
    end

    it "logs an error message" do
      BadProcessStep.new(message_data, app_data).run

      expect(logger_content).to match(
        /ERROR.*BadProcessStep Error while processing message-id/
      )
    end
  end

  it "does not process or log if the message_data `abort` flag has been set to true" do
    message_data.abort = true
    GoodProcessStep.new(message_data, app_data).run

    expect(message_data.has_run).to be_falsey

    expect(logger_content).to eq("")
  end
end 