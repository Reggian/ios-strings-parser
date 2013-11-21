# encoding: UTF-8

require "rspec"
require "ios-strings-parser"

RSpec.configure do |config|
  config.mock_with(:rr)

  def fixture_dir
    @fixture_dir ||= File.join(File.dirname(__FILE__), "fixtures")
  end
end
