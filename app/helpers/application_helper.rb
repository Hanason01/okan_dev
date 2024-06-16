module ApplicationHelper
  def page_title(title)
    base_title = 'ポモドーロおかん'
    title.empty? ? base_title : "#{title} | #{base_title}"
  end
end
