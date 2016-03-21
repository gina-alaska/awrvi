require 'test_helper'

class AbilityTest < ActiveSupport::TestCase
  def test_guests
    user = User.new
    ability = Ability.new(user)

    assert ability.can?(:read, indices(:one)), "Guest cannot read index"
    assert ability.cannot?(:create, Index.new), "Guest can create Index"
    assert ability.cannot?(:edit, indices(:one)), "Guest can edit Index"
    assert ability.cannot?(:destroy, indices(:one)), "Guest can delete Index"
  end

  def test_users
    user = users(:one)
    ability = Ability.new(user)

    assert ability.can?(:read, users(:one)), 'User cannot read themself'
    assert ability.can?(:update, users(:one)), 'User cannot update themself'
    assert ability.cannot?(:read, users(:two)), 'User can read other users'

    assert ability.cannot?(:create, Choice.new), "User can create a choice"
    assert ability.cannot?(:read, Choice.new), "User can read a choice"
    assert ability.cannot?(:update, Choice.new), "User can update a choice"

    assert ability.can?(:create, Index.new), "User cannot create index"

    assert ability.can?(:manage, indices(:one)), "User cannot manage their index"
    assert ability.cannot?(:edit, indices(:two)), "User can edit index they don't own"
    assert ability.can?(:destroy, indices(:unfinalized)), "User cannot destroy their unfinalized index"
    assert ability.cannot?(:destroy, indices(:two)), "User can destroy an index they don't own"
  end

  def test_admins
    user = users(:category_admin)
    category_ability = Ability.new(user)

    user = users(:one)
    user.user_admin = true
    user_ability = Ability.new(user)

    assert category_ability.can?(:create, Choice.new), "category_admin cannot create choices"
    assert category_ability.can?(:read, choices(:low)), "category_admin cannot read choices"
    assert category_ability.can?(:edit, choices(:low)), "category_admin cannot edit choices"
    assert category_ability.can?(:destroy, choices(:low)), "category_admin cannot delete choices"

    assert user_ability.can?(:create, User.new), 'User Admin cannot create users'
    assert user_ability.can?(:read, users(:one)), 'User Admin cannot create users'
    assert user_ability.can?(:edit, users(:one)), 'User Admin cannot edit users'
    assert user_ability.can?(:destory, users(:one)), 'User Admin cannot delete users'
  end
end
