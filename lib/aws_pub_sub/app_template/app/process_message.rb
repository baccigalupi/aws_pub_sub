module App
  class ProcessMessage < AwsPubSub::Subscriber::ProcessMessage
    def processor_classes
      [
        # TODO: Change this to reflect your message processing flow.
        # Each entry should be a class. For convenience, you can inherit
        # these classes from AwsPubSub::Subscriber::ProcessStep.
        #
        Parse,
        # FindStuffInDatabase,
        # MakeSomeDecision,
        # SaveDecisionRecord,
        # PublishDesicion
      ]
    end
  end
end
