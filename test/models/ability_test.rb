require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  def test_users_can_only_read_themselves
    user = users(:one)
    ability = Ability.new(user)
    assert ability.can?(:read, users(:one)), 'User cannot read themself'
    assert ability.can?(:update, users(:one)), 'User cannot update themself'
    assert ability.cannot?(:read, User.new), 'User can read other users'
  end

  def test_admins_can_manage_all_users
    user = users(:one)
    user.user_admin = true
    ability = Ability.new(user)

    assert ability.can?(:manage, User.new), 'User Admin cannot manage users'
  end
end
