# frozen_string_literal: true

class IsAdminConstraint
  include UserAware

  def matches?(request)
    user = current_user(request)
    user.present? && user.admin?
  end
end
