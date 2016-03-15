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

  def test_users_cannot_create_choices
    user = users(:one)
    ability = Ability.new(user)

    assert ability.cannot?(:create, Choice.new), "User can create a choice"
    assert ability.cannot?(:read, Choice.new), "User can read a choice"
    assert ability.cannot?(:update, Choice.new), "User can update a choice"
  end

  def test_only_category_admin_can_edit
    user = users(:category_admin)
    ability = Ability.new(user)

    assert ability.can?(:manage, choices(:med)), "Category admin cannot manage choices"
    assert ability.can?(:edit, choices(:low)), "category_admin cannot edit choices"
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
end
