class Memo < ApplicationRecord
  require 'redcarpet'
  belongs_to :user

  def markdown_render
    unless @markdown
      renderer = Redcarpet::Render::HTML.new
      @markdown = Redcarpet::Markdown.new(renderer)
    end

    @markdown_render ||= @markdown.render(body)
  end
end
