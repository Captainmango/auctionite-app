# frozen_string_literal: true

class AddressAbility
  include CanCan::Ability

  def initialize(user)
    can %i[read create], Address
    can %i[update destroy], Address do |address|
      address.addressable_type == 'User' && address.addressable_id == user.id
    end
  end
end
