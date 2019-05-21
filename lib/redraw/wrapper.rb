module Redraw
  class Wrapper
    attr_reader :hash

    def initialize(hash)
      @hash = hash
    end

    def as_json
      JSON.generate(@hash)
    end

    def as_html
      template{ @hash }
    end

    private def template &block
      content = <<~EOF
        <script>
        var chart = c3.generate(
            #{JSON.pretty_generate(block.call)}
          );
        </script>
      EOF
      content.html_safe
    end
  end
end
