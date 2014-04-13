module ApplicationHelper

  def get_content_for(key)
    if SiteContent.find_by_key(key).nil?
      "Content Unavailable"
    else
      raw(SiteContent.find_by_key(key).value)

    end
  end

end
