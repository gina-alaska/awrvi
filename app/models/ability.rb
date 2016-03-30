class Ability
  include CanCan::Ability

  def initialize(user, namespace = nil)
    user ||= User.new

    can [:read, :update], User, id: user.id

    case namespace
    when 'manage'; manage_abilities(user)
    else;          default_abilities(user)
    end
  end

  def manage_abilities(user)
    can :update, Index if user.index_admin?
    can :manage, User if user.user_admin?
  end

  def default_abilities(user)
    if user.category_admin?
      can :manage, Category
      can :manage, Choice
    end

    unless user.new_record?
      can [:create, :update, :destroy, :publish], Index, user_id: user.id, hidden: false, published_at: nil
    end

    can :read, Community
    can :read, Index, hidden: false
    can :hide, Index if user.index_admin?
  end
end
