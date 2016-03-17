require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  def test_users_can_only_read_themselves
    user = users(:one)
    ability = Ability.new(user)
    assert ability.can?(:read, users(:one)), 'User cannot read themself'
    assert ability.can?(:update, users(:one)), 'User cannot update themself'
    assert ability.cannot?(:read, users(:two)), 'User can read other users'
  end

  def test_admins_can_manage_all_users
    user = users(:one)
    user.user_admin = true
    ability = Ability.new(user)

    assert ability.can?(:manage, User.new), 'User Admin cannot manage users'
  end

  def test_users_can_create_indices
    user = users(:one)
    ability = Ability.new(user)

    assert ability.can?(:create, Index.new), "User cannot create index"
  end

  def test_guests_can_only_read_indicies
    user = User.new
    ability = Ability.new(user)

    assert ability.can?(:read, indices(:one)), "Guest cannot read index"
    assert ability.cannot?(:create, Index.new), "Guest can create Index"
  end

  def test_only_indicies_owner_can_edit
    user = users(:one)
    ability = Ability.new(user)

    assert ability.can?(:manage, indices(:one)), "User cannot manage their index"
    assert ability.cannot?(:edit, indices(:two)), "User can edit index they don't own"
  end

  def test_only_update_unfinalized_indicies
    user = users(:one)
    ability = Ability.new(user)

    assert ability.can?(:update, indices(:one)), 'User cannot update an unfinalized index'
  end
end
