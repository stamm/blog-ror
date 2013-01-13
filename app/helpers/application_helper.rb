module ApplicationHelper
  # Return a title on a per-page basis.
  def title
    base_title = "Zagirov"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(email, name)
    gravatar_id = Digest::MD5::hexdigest(email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: name, class: "gravatar")
  end

  def markdown(text)

    render = Redcarpet::Render::HTML.new :filter_html
    extensions = [:fenced_code_blocks, :autolink]

    markdown = Redcarpet::Markdown.new render, *extensions

    return markdown.render text

  end
end
