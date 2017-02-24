class Memo < ApplicationRecord
  require 'redcarpet'
  belongs_to :user

  def markdown_rendered
    unless @markdown
      renderer = Redcarpet::Render::HTML.new(filter_html: true)
      @markdown = Redcarpet::Markdown.new(renderer, {
        autolink: true
      })
    end

    @markdown_rendered ||= @markdown.render(body)
  end
end
