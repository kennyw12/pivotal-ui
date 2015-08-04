require 'securerandom'
require_relative '../lib/div_id'

Hologram::CodeExampleRenderer::Factory.define 'react_wrapped' do
  example_template 'markup_example_template'
  table_template 'markup_table_template'

  lexer { Rouge::Lexer.find(:html) }

  rendered_example do |code|
    div_id = DivId.next_id
    <<-JS
      <div class="styleguide-component-wrapper">
        <div id="#{div_id}"></div>
      </div>
      <script type="text/jsx">
        React.render(
          #{code.strip},
          document.getElementById('#{div_id}')
        );
      </script>
    JS
  end
end
