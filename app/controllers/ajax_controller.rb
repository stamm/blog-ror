class AjaxController < ApplicationController
  def markitup
    require 'coderay'
    require 'coderay/for_redcloth'
    @html = RedCloth.new(params[:data]).to_html
    #markdown = Redcarpet::Markdown.new(AlbinoHTML, fenced_code_blocks: true)
    #@html = markdown.render params[:data]

    render text: @html
  end
end
