class Ability
  include CanCan::Ability

  def initialize(user, namespace = nil)
    user ||= User.new

    can [:read, :update], User, id: user.id
    can :manage, User if user.user_admin?

    if user.category_admin?
      can :manage, Category
      can :manage, Choice
    end

    unless user.new_record?
      can :create, Index
      can :manage, Index, user_id: user.id
    end

    if user.index_admin? and namespace == 'manage'
      can :update, Index
    end

    can :read, Community
    can :read, Index
  end
end
