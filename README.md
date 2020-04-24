# AwsPubSub

AWS sucks. The current best practice for queue management is to publish a
message to a notification topic, which can then (permissions permitting) publish
to a queue.

This is a gem that has some useful code, but also generates a just add water
queue runner.

By design, it expects that each message will be processed in a series of steps
and that you will want logging for these steps to know where things might be
going wrong.

The app deploys to heroku and just goes.

## Installation & usage

Install the gem first with this command:

```bash
  gem install aws_pub_sub
```

Once you have the gem, you can use it to install the app:

```bash
    aws_pub_sub install my_path
```

### Bundle install

The app generator creates a bundle file for you. So just run `bundle install` to get your dependencies.

### Tests

Tests are in rspec, and the app has been setup to just go. Run `rspec` and you are ready.

### ENV vars

Although you can setup more complicated pub sub systems, the simple app flow is that you have one
subscriber queue and one place you are sending notifications.

A sample `.env` and `.env.sample` have been generated for you. Fill in the env vars, or switch to
another scheme for injecting queue/topic ids into the app.

### Running the app

Run `./bin/processor` and you are good. This app logs to standard out copiously, so you should be able to see what is going wrong in your application and where ... Of course, we know you are testing, right? So this last debugging by running is just a safe guard.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/aws_pub_sub. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/aws_pub_sub/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AwsPubSub project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/aws_pub_sub/blob/master/CODE_OF_CONDUCT.md).
