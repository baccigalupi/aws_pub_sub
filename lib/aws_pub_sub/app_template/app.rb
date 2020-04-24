require "rubygems"
require "bundler"

require "forwardable"
require "json"

require "aws_pub_sub"

require_relative "app/process_message"
require_relative "app/process_message/parse"
# add more classes as needed here
require_relative "app/runner"
require_relative "app/types"

environment = AwsPubSub::Config::Environment.new
Bundler.require(*environment.bundler_groups)
environment.load