require "gemoji"
class Redcarpet::Render::OriginalHTML < Redcarpet::Render::HTML
  def postprocess(full_document)
    full_document.gsub(/:([\w+-]+):/) do |match|
      if emoji = Emoji.find_by_alias($1)
        emoji.raw
      else
        match
      end
    end
  end
end
