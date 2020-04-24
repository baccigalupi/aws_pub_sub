module AwsPubSub
  module AwsSpecFuckery
    def stub_aws_credential_check
      allow_any_instance_of(
        Aws::InstanceProfileCredentials
      ).to receive(:get_credentials).and_return('{}')
    end
  end
end