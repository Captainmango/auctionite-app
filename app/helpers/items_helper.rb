# frozen_string_literal: true

module ItemsHelper
  def item_image_url(item)
    return url_for(item.main_image) if item.main_image.attached?

    "https://picsum.photos/id/#{rand(1..7)}/200"
  end
end
