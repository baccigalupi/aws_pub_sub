require "rubygems"
require "bundler"

require "forwardable"
require "json"

Bundler.require(:default)
require "aws_pub_sub"

require_relative "app/process_message"
require_relative "app/process_message/parse"
# add more classes as needed here
require_relative "app/runner"
require_relative "app/types/app_data"
require_relative "app/types/message_data"

environment = AwsPubSub::Config::Environment.new
Bundler.require(*environment.bundler_groups)
environment.load