# frozen_string_literal: true

module ItemsHelper
  def item_image_url(item)
    return url_for(item.images.first) if item.images.attached?

    'https://picsum.photos/id/9/200'
  end
end
