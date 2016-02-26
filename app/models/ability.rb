class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can [:read, :update], User, id: user.id
    can :manage, User if user.user_admin?

    if user.category_admin?
      can :manage, Category
      can :manage, Choice
    end

    can :read, Community
    can :read, Index
    can :read, Choice
  end
end
