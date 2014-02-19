# encoding: UTF-8

require 'treetop'

require 'ios-strings-parser/strings'
require 'ios-strings-parser/nodes'
require 'ios-strings-parser/regex_parser'

module IosStringsParser
  # to kinda mask the redundancy Treetop generates
  Parser = IosStringsParser
end
