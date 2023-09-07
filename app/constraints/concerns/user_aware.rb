# frozen_string_literal: true

module UserAware
  def current_user(request)
    User.find_by(id: request.session[:user_id])
  end
end
