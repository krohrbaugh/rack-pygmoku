module Specs
  module HtmlHelper
    def html_doc_containing(body)
      html =
%Q{<!DOCTYPE HTML>
<html>
<head><title>Test Markup</title></head>
<body>
#{body}
</body>
</html>
}
      [html]
    end
  end
end
