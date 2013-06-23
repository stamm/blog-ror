class MarkdownRenderer < Redcarpet::Render::HTML
  def block_code(code, language)
    CodeRay.highlight(code, language, { css: :class }, :div)
  end

  def self.markdown(text)

    render = MarkdownRenderer.new filter_html: true, hard_wrap: true
    options = {
        fenced_code_blocks: true,
        no_intra_emphasis: true,
        autolink: true,
        strikethrough: true,
        lax_html_blocks: true,
        superscript: true
    }
    markdown_to_html = Redcarpet::Markdown.new render, options
    markdown_to_html.render(text).html_safe
  end
end