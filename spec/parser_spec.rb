# encoding: UTF-8

require 'spec_helper'
require 'yaml'

include IosStringsParser

describe Parser do
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

  def node_class_for(str)
    case str
      when "StringPair"
        StringPair
      when "Comment"
        Comment
    end
  end

  def expected_parse_results
    @expected_parse_results ||= YAML.load_file(
      File.join(File.dirname(__FILE__), "expected_parse_results.yml")
    )
  end

  def check_parse_result(file, parse_results)
    expected = expected_parse_results[File.basename(file)]
    parse_results.size.should == expected.size

    expected.each_with_index do |expected_attrs, idx|
      parse_results[idx].tap do |parse_result|
        parse_result.should be_a(node_class_for(expected_attrs["type"]))
        (expected_attrs.keys - ["type"]).each do |attr|
          parse_result.send(attr.to_sym).should == expected_attrs[attr]
        end
      end
    end
  end

  Dir.glob(File.join(fixture_dir, "**/*.strings")).each do |fixture_file|
    next if File.basename(fixture_file) == 'additional_for_regex_parser.strings'

    it "should parse #{fixture_file} correctly" do
      parser = IosStringsParser::Parser.new
      data = File.read(fixture_file)
        .force_encoding(encoding_for(fixture_file))
        .encode(Encoding::UTF_8)

      parse_result = parser.parse(data).each.to_a
      check_parse_result(fixture_file, parse_result)
    end
  end
end
