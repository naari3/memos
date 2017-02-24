class Memo < ApplicationRecord
  require 'redcarpet'
  belongs_to :user
  has_many  :comments

  def markdown_rendered
    unless @markdown
      renderer = Redcarpet::Render::OriginalHTML.new(filter_html: true, hard_wrap: true)
      @markdown = Redcarpet::Markdown.new(renderer, {
        autolink: true,
        strikethrough: true,
      })
    end

    @markdown_rendered ||= @markdown.render(body)
  end
end
