require 'rack/utils'
require 'nokogiri'

module Rack
  class Pygmoku
    include Rack::Utils

    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)
      headers = HeaderHash.new(headers)

      if highlight?(status, headers)
        content = highlight(response.join)
        headers['Content-Length'] = bytesize(content).to_s
        response = [content]
      end

      [status, headers, response]
    end

    private
      def highlight?(status, headers)
        status == 200 &&
        !headers['Transfer-Encoding'] &&
        headers['Content-Type'] =~ /html/
      end

      def highlight(content)
        require 'pygments'

        element = 'pre>code'

        document = Nokogiri::HTML(content, nil, 'utf-8')
        nodes = document.css(element)
        nodes.each do |node|
          parent_node = node.parent
          lexer = get_lexer(parent_node)
          content = unescape_html(node.content)

          highlighted = Pygments.highlight(content, {:lexer => lexer })
          parent_node.replace(highlighted)
          parent_node.remove()
        end

        document.serialize
      end

      def get_lexer(node)
        attributes = %w(data-lexer data-lang)
        lexer = 'html'

        attributes.each do |attribute|
          lexer = node[attribute] if node.has_attribute?(attribute)
        end

        lexer
      end

      def unescape_html(html)
        html.to_s.gsub(/&#x000A;/i, "\n").gsub("&lt;", '<').gsub(
          "&gt;", '>').gsub("&amp;", '&')
      end
  end
end
