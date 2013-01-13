class AlbinoHTML < Redcarpet::Render::HTML
  def block_code(code, language)
    p language
    if language.nil?
      '<pre>' + code + '</pre>'
    else
      Albino.colorize(code, language)
    end
  end
end