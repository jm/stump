require File.expand_path('../lib/stump/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors = ["Francis Chong"]
  gem.email = ["francis@ignition.hk"]
  gem.description = "Stubbing and mocking for RubyMotion"
  gem.summary = "Stubbing and mocking for RubyMotion"
  gem.homepage = "https://github.com/siuying/motion-stump"

  gem.files = `git ls-files`.split($\)
  gem.test_files = gem.files.grep(%r{^(test|spec|lib_spec|features)/})
  gem.name = "motion-stump"
  gem.require_paths = ["lib"]
  gem.version = Stump::VERSION

  gem.add_dependency 'motion-define-method', '~> 0.1.2'
  gem.add_development_dependency 'motion-redgreen', '~> 0.1.0'
  gem.add_development_dependency 'rake'
end