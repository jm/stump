unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

require 'stump/version'
require 'stump/metaid'
require 'stump/core_ext/test_case'

require 'stump/stub'
require 'stump/mocks'
require 'stump/mock'
require 'stump/proxy'

Motion::Project::App.setup do |app|
  [
    'stump/version.rb',
    'stump/metaid.rb',
    'stump/stub.rb',
    'stump/mocks.rb',
    'stump/mock.rb',
    'stump/proxy.rb'
  ].collect {|f| File.join(File.dirname(__FILE__), f) }
  .reverse
  .each {|f| app.files.unshift(f) }
end