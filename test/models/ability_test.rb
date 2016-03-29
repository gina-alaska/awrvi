require 'test_helper'

module AbilityTests
  class UsersAbilityTest < ActiveSupport::TestCase
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
  end

  class ChoiceAbilityTest < ActiveSupport::TestCase
    def test_users_cannot_create_choices
      user = users(:one)
      ability = Ability.new(user)

      assert ability.cannot?(:create, Choice.new), "User can create a choice"
      assert ability.cannot?(:read, Choice.new), "User can read a choice"
      assert ability.cannot?(:update, Choice.new), "User can update a choice"
      assert ability.cannot?(:destroy, Choice.new), "User can delete a choice"
    end
  end

  class CategoriesAbilityTest < ActiveSupport::TestCase
    def test_only_category_admin_can_edit
      user = users(:category_admin)
      ability = Ability.new(user)

      assert ability.can?(:create, choices(:low_1)), "Category admin cannot create choices"
      assert ability.can?(:read, choices(:low_1)), "Category admin cannot read choices"
      assert ability.can?(:update, choices(:low_1)), "Category admin cannot update choices"
      assert ability.can?(:destroy, choices(:low_1)), "Category admin cannot destroy choices"
    end
  end

  class IndiciesAbilityTest < ActiveSupport::TestCase
    def test_guests_indices_permission
      user = User.new
      ability = Ability.new(user)

      assert ability.cannot?(:create, Index.new(user: user)), "Guest can create index"
      assert ability.can?(:read, indices(:one)), "Guest cannot read index"
      assert ability.cannot?(:update, indices(:one)), "Guest can update Index"
      assert ability.cannot?(:destroy, indices(:one)), "Guest can destroy Index"
    end

    def test_general_user_indices_permission
      user = users(:one)
      ability = Ability.new(user)

      assert ability.can?(:create, Index.new(user: user)), "Logged in user cannot create index"
      assert ability.can?(:read, indices(:one)), "Logged in user cannot read index"
      assert ability.cannot?(:create, Index.new(user: users(:two))), "Logged in user could create index as another user"
    end

    def test_user_owned_indices_permission
      user = users(:one)
      ability = Ability.new(user)

      assert ability.can?(:update, indices(:one)), "Owner cannot update Index"
      assert ability.can?(:destroy, indices(:one)), "Owner cannot destroy Index"
    end

    def test_user_not_owned_indices_permission
      user = users(:two)
      ability = Ability.new(user)

      assert ability.cannot?(:update, indices(:one)), "User can update Index"
      assert ability.cannot?(:destroy, indices(:one)), "User can destroy Index"
    end
  end

  class IndiciesFinalizeTest < ActiveSupport::TestCase
    def test_only_update_unfinalized_indicies
      user = users(:one)
      ability = Ability.new(user)

      assert ability.can?(:update, indices(:unfinalized)), 'User cannot update an unfinalized index'
    end

    def test_cannot_update_finalized_indicies
      user = users(:one)
      ability = Ability.new(user)

      assert ability.cannot?(:update, indices(:complete)), 'User can update a finalized index'
    end

    def test_only_delete_unfinalized_indicies
      user = users(:one)
      ability = Ability.new(user)

      assert ability.can?(:destroy, indices(:unfinalized)), 'User cannot delete an unfinalized index'
    end

    def test_cannot_delete_finalized_indicies
      user = users(:one)
      ability = Ability.new(user)

      assert ability.cannot?(:destroy, indices(:complete)), 'User can delete a finalized index'
    end

    def test_only_user_can_finalize_index
      user = users(:one)
      ability = Ability.new(user)

      assert ability.can?(:finalize, indices(:unfinalized)), 'User cannot finalize their index'
    end
  end
end
