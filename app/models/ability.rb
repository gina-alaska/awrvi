class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can [:read, :update], User, id: user.id
    can :manage, User if user.user_admin?
    can :manage, Category if user.category_admin?

    unless user.new_record?
      can :create, Index
      can [:update, :destroy], Index, finalized_at: nil, user_id: user.id
    end

    can :read, Community
    can :read, Index
  end
end
