require "ostruct"

require "bundler/setup"
require "aws_pub_sub"
require "dotenv"

ENV['APP_ENV'] = 'test'

Dotenv.load

Dir[__dir__ + "/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include AwsPubSub::AwsSpecFuckery
  config.include AwsPubSub::AppDataSpecHelper
  
  config.before do
    stub_aws_credential_check
  end
end
