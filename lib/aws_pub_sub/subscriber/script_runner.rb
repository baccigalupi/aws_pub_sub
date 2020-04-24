STDOUT.sync = true

module AwsPubSub
  class Subscriber
    class ScriptRunner
      attr_reader :runner, :process_name
    
      def initialize(runner, process_name)
        @runner = runner
        @process_name = process_name
      end
    
      def run
        Signal.trap("INT") { 
          puts(" SIGNAL INT: Shutting down #{process_name} queue polling")
          throw :stop_polling 
        }
        
        Signal.trap("TERM") { 
          puts(" SIGNAL TERM: Shutting down #{process_name} queue polling")
          throw :stop_polling
        }
    
        logger.info("Starting #{process_name} queue polling")
    
        runner.run
      end
    
      def logger
        @logger ||= AwsPubSub::Config::BuildLogger.new.run
      end
    end
  end
end
