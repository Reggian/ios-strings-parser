# encoding: UTF-8

require 'treetop'

require 'strings-parser/strings'
require 'strings-parser/nodes'

module StringsParser
  # to kinda mask the redundancy Treetop generates
  Parser = StringsParser
end

# File.unlink("/Users/cdutro/workspace/strings-parser/strings.rb")
# puts `tt /Users/cdutro/workspace/strings-parser/strings.treetop`

# tree = StringsParser::Parser.new.parse("/* A very cool string */\n\"hello\"=\"hola\"")
# parser = StringsParser::Parser.new
# data = File.read("/Users/cdutro/workspace/twitter-ios/Twitter/Localization/en.lproj/Localizable.strings").force_encoding("UTF-16BE").encode("UTF-8")
# data = File.read("/Users/cdutro/Desktop/Localizable.strings")
# tree = parser.parse(data)
# puts data.inspect
# puts tree.inspect
# arr = tree.each.to_a