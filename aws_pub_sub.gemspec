require_relative 'lib/aws_pub_sub/version'

Gem::Specification.new do |spec|
  spec.name          = "aws_pub_sub"
  spec.version       = AwsPubSub::VERSION
  spec.authors       = ["Kane Baccigalupi"]
  spec.email         = ["baccigalupi@gmail.com"]

  spec.summary       = %q{Quick and dirty generator+library for pub/sub on AWS}
  spec.description   = %q{Wraps SQS/SNS in a helpful app that let's you quickly subscribe to a queue and break the work of processing into logged steps.}
  spec.homepage      = "https://www.github.com/baccigalupi/aws_pub_sub"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.add_runtime_dependency "aws-sdk", "~> 3.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
