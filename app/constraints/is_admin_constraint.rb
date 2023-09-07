# frozen_string_literal: true

class IsAdminConstraint
  extend UserAware

  def self.matches?(request)
    user = current_user(request)
    user.present? && user.admin?
  end
end
