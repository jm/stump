unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

require 'motion-define-method'

Motion::Project::App.setup do |app|
  app.development do
    [
      'stump/version.rb',
      'stump/metaid.rb',
      'stump/stub.rb',
      'stump/mocks.rb',
      'stump/mock.rb',
      'stump/proxy.rb',
      'stump/baconize.rb'
    ].collect {|f| File.join(File.dirname(__FILE__), f) }
    .reverse
    .each {|f| app.files.unshift(f) }
  end
end