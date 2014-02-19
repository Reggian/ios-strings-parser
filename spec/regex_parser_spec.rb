# encoding: UTF-8

require 'spec_helper'
require 'yaml'

include IosStringsParser

describe RegexParser do
  def encoding_for(file)
    case File.basename(file).chomp(File.extname(file))
      when "utf8"
        Encoding::UTF_8
      when "utf16le"
        Encoding::UTF_16LE
      when "utf16be"
        Encoding::UTF_16BE
      else
        Encoding::UTF_8
    end
  end

  def expected_parse_results
    @expected_parse_results ||= YAML.load_file(
      File.join(File.dirname(__FILE__), "expected_regex_parse_results.yml")
    )
  end

  def parse_result_to_hash(parse_result)
    parse_result.map do |i|
      Hash[i.each_pair.to_a]
    end
  end

  Dir.glob(File.join(fixture_dir, "**/*.strings")).each do |fixture_file|
    it "should parse #{fixture_file} correctly" do
      parser = IosStringsParser::RegexParser.new
      data = File.read(fixture_file)
        .force_encoding(encoding_for(fixture_file))
        .encode(Encoding::UTF_8)

      parse_result = parser.parse(data)
      parse_result_to_hash(parse_result).should == expected_parse_results[File.basename(fixture_file)]
    end
  end
end
