require 'babel/transpiler'
require_relative '../lib/div_id'

Hologram::CodeExampleRenderer::Factory.define 'react' do
  example_template 'markup_example_template'
  table_template 'markup_table_template'

  lexer { Rouge::Lexer.find(:html) }

  rendered_example do |code|
    div_id = DivId.next_id
    if %w(production staging).include?(ENV['STYLEGUIDE_ENV'])
      js_code = Babel::Transpiler.transform("var reactElement = #{code.strip}")["code"]
      <<-JS
        <div id="#{div_id}"></div>
        <script>
          (function() {
            #{js_code}
            React.render(
              reactElement,
              document.getElementById('#{div_id}')
            );
          })();
        </script>
      JS
    else
      <<-JS
        <div id="#{div_id}"></div>
        <script type="text/jsx">
          (function() {
            React.render(
              #{code.strip},
              document.getElementById('#{div_id}')
            );
          })();
        </script>
      JS
    end
  end
end
