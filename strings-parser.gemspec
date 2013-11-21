$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'strings-parser/version'

Gem::Specification.new do |s|
  s.name     = "strings-parser"
  s.version  = ::StringsParser::VERSION
  s.authors  = ["Cameron Dutro"]
  s.email    = ["cdutro@twitter.com"]
  s.homepage = "http://twitter.com"

  s.description = s.summary = "A parser for iOS .strings files."

  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.summary  = "A parser for iOS .strings files."

  s.add_dependency 'treetop', '~> 1.4.15'

  s.require_path = 'lib'

  gem_files = Dir["{lib,spec}/**/*", "Gemfile", "History.txt", "LICENSE", "Rakefile", "strings-parser.gemspec"]
end
