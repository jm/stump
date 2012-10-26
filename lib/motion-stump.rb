unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

## Extend Motion config to include our spec helper
module Motion; module Project;
  class Config
    alias_method :spec_files_before_stump, :spec_files
    def spec_files
      core = Dir.chdir(motiondir + '/lib/motion') { (['spec.rb'] + Dir.glob(File.join('spec', 'helpers', '*.rb'))).map { |x| File.expand_path(x) } }
      (core + [File.join(File.dirname(__FILE__), 'stump/stump_spec_helper.rb')] + spec_files_before_stump).uniq
    end
  end
end; end


## Include stump in dev mode
Motion::Project::App.setup do |app|
  app.development do
     [
      File.join(File.dirname(__FILE__), 'stump/version.rb'),
      File.join(File.dirname(__FILE__), 'stump/metaid.rb'),
      File.join(File.dirname(__FILE__), 'stump/stub.rb'),
      File.join(File.dirname(__FILE__), 'stump/mocks.rb'),
      File.join(File.dirname(__FILE__), 'stump/mock.rb'),
      File.join(File.dirname(__FILE__), 'stump/proxy.rb'),
      File.join(File.dirname(__FILE__), 'stump/app_delegate.rb')
    ].reverse.each {|f| app.files.unshift(f) }
  end
end
