require 'babel/transpiler'
class DivId
  @current_id = 0

  def self.next_id
    val = "react-example-#{@current_id}"
    @current_id += 1
    val
  end
end

Hologram::CodeExampleRenderer::Factory.define 'react' do
  example_template 'markup_example_template'
  table_template 'markup_table_template'

  lexer { Rouge::Lexer.find(:html) }

  rendered_example do |code|
    js_code = Babel::Transpiler.transform("var tacos = #{code.strip}")["code"]
    div_id = DivId.next_id
    [
      "<div id=\"#{div_id}\"></div>",
      '<script>',
      '  (function() {',
      "    #{js_code}",
      '    React.render(',
      '      tacos,',
      "      document.getElementById('#{div_id}')",
      '    );',
      '  })();',
      '</script>'
    ].join("\n")
  end
end
