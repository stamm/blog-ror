require 'spec_helper'

describe MarkdownRenderer do

  describe 'block_code' do
    it 'parse code' do
      rend = MarkdownRenderer.new

      rend.block_code('$a = "test"', 'php').should == "<div class=\"CodeRay\">\n  <div class=\"code\"><pre><span class=\"local-variable\">$a</span> = <span class=\"string\"><span class=\"delimiter\">&quot;</span><span class=\"content\">test</span><span class=\"delimiter\">&quot;</span></span></pre></div>\n</div>\n"
    end
  end

  describe 'markdown' do
    it 'make markdown' do
      MarkdownRenderer.markdown('## test').should == '<h2>test</h2>\n'
      MarkdownRenderer.markdown('http://yandex.ru').should == "<p><a href=\"http://yandex.ru\">http://yandex.ru</a></p>\n"
    end
  end
end