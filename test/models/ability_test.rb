# frozen_string_literal: true

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
      user = users(:user_admin)
      ability = Ability.new(user, 'manage')

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
      assert ability.can?(:read, indices(:published)), "Guest cannot read index"
      assert ability.cannot?(:update, indices(:unpublished)), "Guest can update Index"
      assert ability.cannot?(:destroy, indices(:unpublished)), "Guest can destroy Index"
    end

    def test_general_user_indices_permission
      user = users(:one)
      ability = Ability.new(user)

      assert ability.can?(:create, Index.new(user: user)), "Logged in user cannot create index"
      assert ability.can?(:read, indices(:published)), "Logged in user cannot read index"
      assert ability.cannot?(:create, Index.new(user: users(:two))), "Logged in user could create index as another user"
    end

    def test_user_owned_indices_permission
      user = users(:one)
      ability = Ability.new(user)

      assert ability.can?(:update, indices(:unpublished)), "Owner cannot update Index"
      assert ability.can?(:destroy, indices(:unpublished)), "Owner cannot destroy Index"
    end

    def test_user_not_owned_indices_permission
      user = users(:two)
      ability = Ability.new(user)

      assert ability.cannot?(:update, indices(:published)), "User can update Index"
      assert ability.cannot?(:destroy, indices(:published)), "User can destroy Index"
    end

    def test_expert_reviewer_can_not_review_unpublished_index
      user = users(:expert_reviewer)
      ability = Ability.new(user)

      assert ability.cannot?(:review, indices(:unpublished)), "User can review unpublished Index"
    end
  end

  class IndiciesPublishedTest < ActiveSupport::TestCase
    def test_only_update_unpublished_indicies
      user = users(:two)
      ability = Ability.new(user)

      assert ability.can?(:update, indices(:incomplete)), 'User cannot update an unpublished index'
    end

    def test_cannot_update_published_indicies
      user = users(:one)
      ability = Ability.new(user)

      assert ability.cannot?(:update, indices(:complete)), 'User can update a published index'
    end

    def test_only_delete_unpublished_indicies
      user = users(:two)
      ability = Ability.new(user)

      assert ability.can?(:destroy, indices(:incomplete)), 'User cannot delete an unpublished index'
    end

    def test_cannot_delete_published_indicies
      user = users(:one)
      ability = Ability.new(user)

      assert ability.cannot?(:destroy, indices(:complete)), 'User can delete a published index'
    end

    def test_only_user_can_publish_index
      user = users(:two)
      ability = Ability.new(user)

      assert ability.can?(:publish, indices(:incomplete)), 'User cannot published their index'
    end

    def test_index_admin_can_update_indices
      user = users(:index_admin)
      ability = Ability.new(user, 'manage')

      assert ability.can?(:update, indices(:published)), "Admin cannot update index"
    end

    def test_index_admin_can_hide_indices
      user = users(:index_admin)
      ability = Ability.new(user)

      assert ability.can?(:hide, indices(:published)), "Admin cannot hide index"
    end

    def test_cannot_hide_unpublished_indices
      user = users(:index_admin)
      ability = Ability.new(user)

      assert ability.cannot?(:hide, indices(:unpublished)), "Admin can hide unpublished Index"
    end

    def test_manager_cannot_update_unpublished_indices
      user = users(:index_admin)
      ability = Ability.new(user, 'manager')

      assert ability.cannot?(:update, indices(:unpublished)), "Admin can update unpublished Index"
    end

    def test_admin_cannot_update_indices
      user = users(:index_admin)
      ability = Ability.new(user)
      assert ability.cannot?(:update, indices(:unpublished)), "Admin can update index"
    end

    def test_expert_reviewer_can_review_published_index
      user = users(:expert_reviewer)
      ability = Ability.new(user)
      assert ability.can?(:review, indices(:published)), "Expert reviewer can not review published index"
    end
  end
end
