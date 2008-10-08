Gem::Specification.new do |s|
  s.name     = "stump"
  s.version  = "0.0.1"
  s.date     = "2008-10-07"
  s.summary  = "Stubbing and mocking that isn't painful."
  s.email    = "jeremy@entp.com"
  s.homepage = "http://github.com/jeremymcanally/stump"
  s.description = "Stubbing and mocking that isn't painful, fanciful, and doesn't inspire any sort of contempt or bitterness."
  s.has_rdoc = true
  s.authors  = ["Jeremy McAnally"]
  s.files    = [
    "History.txt", 
  	"Manifest.txt", 
  	"README.rdoc", 
  	"Rakefile", 
  	"stump.gemspec", 
    "History.txt",
    "License.txt",
    "Manifest.txt",
    "PostInstall.txt",
    "Rakefile",
    "config/hoe.rb",
    "config/requirements.rb",
    "lib/stump.rb",
    "lib/stump/metaid.rb",
    "lib/stump/mock.rb",
    "lib/stump/mocks.rb",
    "lib/stump/stub.rb",
    "lib/stump/proxy.rb",
    "lib/stump/version.rb",
    "lib/stump/core_ext/test_case.rb",
    "setup.rb"
  ]
  
  s.test_files = [
    "test/test_stub.rb",
    "test/test_mock.rb",
    "test/test_proxy.rb",
    "test/test_helper.rb"
  ]

  s.rdoc_options = ["--main", "README.rdoc"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.rdoc"]
end