unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

## Extend Motion config to include our spec helper
module Motion; module Project;
  class Config
    alias_method :spec_files_before_stump, :spec_files
    def spec_files
      core = Dir.chdir(motiondir + '/lib/motion') { (['spec.rb'] + Dir.glob(File.join('spec', 'helpers', '*.rb'))).map { |x| File.expand_path(x) } }
      (core + [File.join(File.dirname(__FILE__), 'lib/stump_spec_helper.rb')] + spec_files_before_stump).uniq
    end
  end
end; end

## Include supports for define_method
require 'motion-define-method'

## Include stump in dev mode
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