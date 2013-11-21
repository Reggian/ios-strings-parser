$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'ios-strings-parser/version'

Gem::Specification.new do |s|
  s.name     = "ios-strings-parser"
  s.version  = ::IosStringsParser::VERSION
  s.authors  = ["Cameron Dutro"]
  s.email    = ["cdutro@twitter.com"]
  s.homepage = "http://twitter.com"

  s.description = s.summary = "A parser for iOS .strings files."

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.summary  = "A parser for iOS .strings files."

  s.add_dependency 'treetop', '~> 1.4.15'

  s.require_path = 'lib'

  s.files = Dir["{lib,spec}/**/*", "Gemfile", "History.txt", "LICENSE", "Rakefile", "ios-strings-parser.gemspec"]
end
