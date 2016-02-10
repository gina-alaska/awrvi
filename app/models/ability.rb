class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can [:read, :update], User, id: user.id
    can :manage, User if user.user_admin?

    can :read, Community
    can :read, Index
  end
end
