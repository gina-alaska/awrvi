# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user, namespace = nil)
    user ||= User.new

    can %i[read update], User, id: user.id

    case namespace
    when 'manage' then manage_abilities(user)
    else               default_abilities(user)
    end
  end

  def manage_abilities(user)
    can :update, Index if user.index_admin?
    cannot :update, Index, published_at: nil
    can :manage, User if user.user_admin?
  end

  def default_abilities(user)
    if user.category_admin?
      can :manage, Category
      can :manage, Choice
    end

    can %i[create update destroy publish], Index, user_id: user.id, hidden: false, published_at: nil unless user.new_record?

    can :read, Community
    can :read, Index, hidden: false
    can :hide, Index if user.index_admin?
    cannot :hide, Index, published_at: nil

    can :manage, Review, user_id: user.id if user.expert_reviewer?
    can :review, Index if user.expert_reviewer?
    cannot :review, Index, published_at: nil
  end
end
