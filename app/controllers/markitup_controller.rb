class MarkitupController < ApplicationController
  def preview

    @html = MarkdownRenderer.markdown params[:data]
    # markdown = Redcarpet::Markdown.new(AlbinoHTML, fenced_code_blocks: true)
    # @html = markdown.render params[:data]

    render text: @html
  end
end
