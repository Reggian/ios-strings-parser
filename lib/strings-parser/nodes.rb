# encoding: UTF-8

module StringsParser

  Comment = Struct.new(:text)
  StringPair = Struct.new(:meta_key, :key)
  CommentedStringPair = Struct.new(:meta_key, :key, :comment)

  module Strings

    class StringList < Treetop::Runtime::SyntaxNode
      include Enumerable

      def each(&block)
        block ? yield_each(&block) : to_enum(:yield_each)
      end

      def each_pair(&block)
        block ? yield_each_pair(&block) : to_enum(:yield_each_pair)
      end

      private

      def root
        elements[1].elements
      end

      def yield_each
        root.each do |node|
          case node
            when CommentNode
              yield Comment.new(node.text)
            when StringNode
              yield StringPair.new(node.get_meta_key, node.get_key)
          end
        end
      end

      def yield_each_pair
        comment = NullComment.instance
        string = NullString.instance

        root.each do |node|
          case node
            when CommentNode
              comment = node
            when StringNode
              string = node

              yield CommentedStringPair.new(
                string.get_meta_key, string.get_key, comment.text
              )

              comment = NullComment.instance
              string = NullString.instance
          end
        end
      end
    end

    class StringNode < Treetop::Runtime::SyntaxNode
      def get_key
        unescape(key.elements[1].text_value)
      end

      def get_meta_key
        unescape(meta_key.elements[1].text_value)
      end

      private

      def unescape(str)
        if str
          str.gsub('\\"', '"')
        else
          str
        end
      end
    end

    class CommentNode < Treetop::Runtime::SyntaxNode
      def text
        elements[1].text_value
      end
    end

    class NullComment
      def self.instance
        @instance ||= new
      end

      def text
        ""
      end
    end

    class NullString
      def self.instance
        @instance ||= new
      end

      def get_key
        ""
      end

      def get_meta_key
        ""
      end
    end

  end
end