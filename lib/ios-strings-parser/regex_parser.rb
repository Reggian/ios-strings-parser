module IosStringsParser
  class RegexParser
    IosString = Struct.new(:meta_key, :key, :comment)

    REGEX = /
      \/\*[\s]*(?<comment>.*?)[\s]*\*\/ # multi line comment
      |
      \/\/\s*(?<comment>.*?)\s*\n # single line comment
      |
      "(?<meta_key>.*?)"\s*=\s*"(?<key>.*?)"\s*; # string
    /mx

    def parse(input)
      strings = []
      current_comment = ''

      input.to_enum(:scan, REGEX).each do
        match = Regexp.last_match
        current_comment = match[:comment] if match[:comment]

        if match[:meta_key] && match[:key]
          strings << IosString.new(
            unescape_string(match[:meta_key]),
            unescape_string(match[:key]),
            current_comment
          )
          current_comment = ''
        end
      end

      # for a compatibility
      class << strings
        def each_pair
          self
        end
      end

      strings
    end

    private

    def unescape_string(string)
      string.gsub('\"', '"').gsub("\\'", "'").gsub('\\\\', '\\')
    end
  end
end
