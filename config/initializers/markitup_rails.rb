Markitup::Rails.configure do |config|
  config.formatter = -> markup { MarkdownRenderer.markdown(markup) }
end