require 'rack/utils'
require 'nokogiri'

module Rack
  class Pygmoku
    include Rack::Utils

    def initialize(app, opts={})
      @app = app
      @opts = default_opts.merge(opts)
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

        element = @opts[:element]

        document = Nokogiri::HTML(content, nil, 'utf-8')
        nodes = document.css(element)
        nodes.each do |node|
          parent_node = node.parent
          lexer = get_lexer(parent_node)

          highlighted = Pygments.highlight(
            node.content, {:lexer => lexer })
          parent_node.replace(highlighted)
          parent_node.remove()
        end

        document.serialize
      end

      def get_lexer(node)
        attribute = @opts[:lexer_attr]
        lexer = 'html'
        lexer = node[attribute] if node.has_attribute?(attribute)
        lexer
      end

      def default_opts
        {
          :element => 'pre>code',
          :lexer_attr => 'data-lang'
        }
      end
  end
end
