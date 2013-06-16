unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

## Extend Motion config to include our spec helper
module Motion; module Project;
  class Config
    alias_method :spec_core_files_without_stump, :spec_core_files
    def spec_core_files
      spec_core_files_without_stump + [File.join(File.dirname(__FILE__), 'motion/stump_spec_helper.rb')]
    end
  end
end; end

## Include stump in dev mode
Motion::Project::App.setup do |app|
  app.development do
    stump_lib_dir = File.join(File.dirname(__FILE__), 'stump')
    stump_files = Dir.glob(stump_lib_dir + "/**/*.rb")
    app.files.unshift(stump_files)
  end
end
